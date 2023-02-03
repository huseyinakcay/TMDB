//
//  DetailVcTableViewCell.swift
//  TMDB
//
//  Created by Huseyin Akcay on 3.02.2023.
//

import UIKit

final class DetailVcTableViewCell: BaseTableViewCell {
    //MARK: - Properties
    private let constants = Constants.Detail.self
    //MARK: - UI Components
    lazy private var containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.addArrangedSubview(posterImageViewContainer)
        view.addArrangedSubview(detailStackView)
        view.spacing = 10
        return view
    }()

    lazy private var posterImageViewContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()

    lazy private var posterImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()

    lazy private var ratingLabelContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .red.withAlphaComponent(0.7)
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()

    lazy private var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: commonFont, size: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    lazy private var detailStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        view.addArrangedSubview(titleLabel)
        view.addArrangedSubview(firstEpisodeDateLabel)
        view.addArrangedSubview(lastEpisodeDateLabel)
        view.addArrangedSubview(inProductionLabel)
        view.addArrangedSubview(typeLabel)
        view.addArrangedSubview(creatorLabel)
        return view
    }()

    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: commonFont, size: 20)
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }()

    lazy private var firstEpisodeDateLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.font = UIFont(name: commonFont, size: 16)
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }()

    lazy private var lastEpisodeDateLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.font = UIFont(name: commonFont, size: 16)
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }()

    lazy private var inProductionLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.font = UIFont(name: commonFont, size: 16)
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }()

    lazy private var typeLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.font = UIFont(name: commonFont, size: 16)
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }()

    lazy private var creatorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.font = UIFont(name: commonFont, size: 16)
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }()

    lazy private var overviewLabelContainerView: UIView = {
        let view = UIView()
        return view
    }()

    lazy private var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: commonFont, size: 20)
        label.textColor = .white
        label.numberOfLines = .zero
        return label
    }()

    //MARK: - Configure UI
    override func setupViews() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerStackView)
        contentView.addSubview(overviewLabelContainerView)
        posterImageViewContainer.addSubview(posterImageView)
        posterImageViewContainer.addSubview(ratingLabelContainer)
        ratingLabelContainer.addSubview(ratingLabel)
        overviewLabelContainerView.addSubview(overviewLabel)
    }

    override func setupLayout() {
        containerStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }

        posterImageViewContainer.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(3)
            make.height.equalTo(posterImageViewContainer.snp.width).multipliedBy(1.5)
        }

        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        overviewLabelContainerView.snp.makeConstraints { make in
            make.top.equalTo(containerStackView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(containerStackView)
            make.bottom.equalToSuperview()
        }

        overviewLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualTo(100)
        }
        ratingLabelContainer.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(8)
            make.size.equalTo(32)
        }
        ratingLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    //MARK: - Methods
    func setCell(
        with model: ShowDetailResponseModel?,
        mainModel: Results?,
        posterImage: UIImage?
    ) {
        guard let model = model else {
            return
        }
        var isInProd: String {
            if !(model.inProduction ?? false) {
                return constants.yes
            } else {
                return constants.no
            }
        }
        self.ratingLabelContainer.isHidden = false
        self.titleLabel.text = "\(model.name ?? "")"
        self.firstEpisodeDateLabel.addAttribute(
            text: "\(constants.firstEpisode) \(model.firstAirDate ?? "N/A")",
            attText: constants.firstEpisode,
            color: .red.withAlphaComponent(0.7),
            highletedFont: UIFont(name: commonFont, size: 18)!
        )
        self.lastEpisodeDateLabel.addAttribute(
            text: "\(constants.lastEpisode) \(model.lastAirDate ?? "N/A")",
            attText: constants.lastEpisode,
            color: .red.withAlphaComponent(0.7),
            highletedFont: UIFont(name: commonFont, size: 18)!
        )
        self.inProductionLabel.addAttribute(
            text: "\(constants.didItEnd) \(isInProd)",
            attText: constants.didItEnd,
            color: .red.withAlphaComponent(0.7),
            highletedFont: UIFont(name: commonFont, size: 18)!
        )
        self.typeLabel.addAttribute(
            text: "\(constants.genre) \(model.type ?? "N/A")",
            attText: constants.genre,
            color: .red.withAlphaComponent(0.7),
            highletedFont: UIFont(name: commonFont, size: 18)!
        )
        self.creatorLabel.addAttribute(
            text: "\(constants.creator) \(model.createdBy?.first?.name ?? "N/A")",
            attText: constants.creator,
            color: .red.withAlphaComponent(0.7),
            highletedFont: UIFont(name: commonFont, size: 18)!
        )
        self.overviewLabel.text = model.overview
        self.posterImageView.image = posterImage
        self.ratingLabel.text = "\(mainModel?.voteAverage ?? 0.0)"
        self.titleLabel.text = mainModel?.name
    }
}
