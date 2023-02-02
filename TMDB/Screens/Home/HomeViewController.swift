//
//  HomeViewController.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit
import SnapKit

class HomeViewController: BaseVC {
    //MARK: - Properties
    var model: [Results] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    //MARK: - UI Components
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.register(HomeVcCollectionViewCell.self, forCellWithReuseIdentifier: "HomeVcCollectionViewCell")
        collView.showsVerticalScrollIndicator = false
        collView.showsHorizontalScrollIndicator = false
        collView.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        collView.delegate = self
        collView.dataSource = self
        collView.backgroundColor = .black
        collView.backgroundView?.isHidden = true
        return collView
    }()

    var page = 1
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "TMDB"

        fetchMovies(page: page)
    }

    //MARK: - Configure UI
    override func setupViews() {
        view.addSubview(collectionView)
    }

    override func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo((UIScreen.main.bounds.width - 60) / 2 * 1.5)
        }
    }

    //MARK: - Methods
    func fetchMovies(page: Int) {
        APIService.request(router: TvShowsEndpoint.popularShows(page: page)) { (response: PopularShowsResponseModel?, error: String?) in
            self.model += response?.results ?? []
            self.page += 1
        } onFailure: { (errorDescription, networkErrorType) in
            print("fail")
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVcCollectionViewCell", for: indexPath) as! HomeVcCollectionViewCell
        cell.setCell(model: model[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 60) / 2
        let height: CGFloat = width * 1.5
        return CGSize(width: width, height: height)
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !model.isEmpty {
            let currentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height

            if maximumOffset - currentOffset <= 200.0 {
                self.fetchMovies(page: page)
            }
        }
    }

}
