//
//  HomeViewController.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit
import SnapKit

final class HomeViewController: BaseVC {
    //MARK: - Properties
    private var viewModel: HomeViewModel?
    private let constants = Constants.Home.self
    private let spacing: CGFloat = 20

    //MARK: - UI Components
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        let collView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collView.register(
            HomeVcCollectionViewCell.self,
            forCellWithReuseIdentifier: constants.homeCvCell
        )
        collView.showsVerticalScrollIndicator = false
        collView.showsHorizontalScrollIndicator = false
        collView.contentInset = UIEdgeInsets(
            top: spacing,
            left: spacing,
            bottom: spacing,
            right: spacing
        )
        collView.delegate = self
        collView.dataSource = self
        collView.backgroundColor = .black
        collView.backgroundView?.isHidden = true
        collView.bounces = false
        return collView
    }()

    //MARK: - Lifecycle
    init(viewModel: HomeViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureNavBar()
    }

    //MARK: - Configure UI
    override func setupViews() {
        view.addSubview(collectionView)
    }

    override func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func configureNavBar() {
        navigationController?.navigationBar.isHidden = true
    }

    //MARK: - Methods
    private func fetchMovies() {
        viewModel?.fetchMovies { [weak self] (firstIndex, endIndex) in
            guard let self = self else { return }
            for item in firstIndex...endIndex {
                self.collectionView.reloadItems(at: [IndexPath(
                    item: item,
                    section: .zero
                )])
            }
        } onFailure: { [weak self] (errorDescription, networkError) in
            guard let self = self else { return }
            self.showAlert(
                title: commonError,
                message: errorDescription ?? APIError.unknownError.errorDescription
            )
        }
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: constants.homeCvCell,
            for: indexPath
        ) as? HomeVcCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setCell(with: viewModel?.results[indexPath.item])
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel?.results.count ?? 0
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let navigationController = navigationController,
              let viewModel = viewModel else { return }
        let item = collectionView.cellForItem(at: indexPath) as! HomeVcCollectionViewCell
        let posterImage = item.getImage()
        let detailVm = DetailViewModel(mainModel: viewModel.results[indexPath.item], posterImage: posterImage!)
        let detailVc = DetailViewController(viewModel: detailVm)
        navigationController.pushViewController(detailVc, animated: true)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - spacing * 3) / 2
        let height: CGFloat = width * 1.5
        return CGSize(width: width, height: height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !(viewModel?.results.isEmpty ?? true) {
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

            if maximumOffset - currentOffset <= 300.0 &&
                !(viewModel?.isLastPage ?? true) {
                self.fetchMovies()
            }
        }
    }
}
