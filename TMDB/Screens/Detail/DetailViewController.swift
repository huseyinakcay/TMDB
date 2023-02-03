//
//  DetailViewController.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit

final class DetailViewController: BaseVC {
    //MARK: - Properties
    var viewModel: DetailViewModel?
    private let constants = Constants.Detail.self
    
    //MARK: - UI Components
    lazy private var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(
            DetailVcTableViewCell.self,
            forCellReuseIdentifier: constants.detailTvCell
        )
        view.estimatedRowHeight = UITableView.automaticDimension
        view.rowHeight = UITableView.automaticDimension
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.allowsSelection = false
        view.separatorStyle = .none
        view.backgroundColor = .black
        view.contentInset = .zero
        view.dataSource = self
        view.bounces = false
        return view
    }()

    //MARK: - Lifecycle
    init(viewModel: DetailViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        title = constants.detail
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        fetchShowDetail()
    }

    //MARK: - Configure UI
    override func setupViews() {
        super.setupViews()

        view.backgroundColor = .black
        view.addSubview(tableView)
    }

    override func setupLayout() {
        super.setupLayout()

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func configureNavBar() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.topItem?.title = ""
    }

    //MARK: - Methods
    private func fetchShowDetail() {
        viewModel?.fetchShowDetail { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        } onFailure: { [weak self] (errorDescription, networkError) in
            guard let self = self else { return }
            self.showAlert(
                title: commonError,
                message: errorDescription ?? APIError.unknownError.errorDescription
            )
        }

    }
}

//MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int { return 1 }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: constants.detailTvCell,
            for: indexPath
        ) as? DetailVcTableViewCell else {
            return UITableViewCell()
        }
        cell.setCell(
            with: viewModel?.model,
            mainModel: viewModel?.mainModel,
            posterImage: viewModel?.posterImage
        )
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat { return UITableView.automaticDimension }
}
