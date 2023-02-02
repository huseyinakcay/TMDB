//
//  HomeVcCollectionViewCell.swift
//  TMDB
//
//  Created by Huseyin Akcay on 2.02.2023.
//

import UIKit
import Kingfisher

final class HomeVcCollectionViewCell: BaseCollectionViewCell {
    //MARK: - UI Components
    lazy private var movieContainerView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.6
        view.layer.shadowRadius = 8
        view.layer.cornerRadius = 16
        view.backgroundColor = .black
        return view
    }()

    lazy private var movieStackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.alignment = .fill
        view.addArrangedSubview(movieImageViewContainerView)
        view.axis = .vertical
        return view
    }()

    lazy private var movieImageViewContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        return view
    }()

    lazy private var movieImageView: UIImageView = {
        let view = UIImageView(image: nil)
        view.contentMode = .scaleToFill
        return view
    }()

    lazy private var averageVoteView: UIView = {
        let view = UIView()
        view.backgroundColor = .red.withAlphaComponent(0.7)
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    lazy private var averageVoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: commonFont, size: 12)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: commonFont, size: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.isHidden = true
        return label
    }()

    lazy private var bottomTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = .red.withAlphaComponent(0.7)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()

    lazy private var bottomTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: commonFont, size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    //MARK: - Configure UI
    override func setupViews() {
        super.setupViews()

        contentView.addSubview(movieContainerView)
        movieContainerView.addSubview(movieStackView)
        movieImageViewContainerView.addSubview(titleLabel)
        movieImageViewContainerView.addSubview(movieImageView)
        movieImageViewContainerView.addSubview(averageVoteView)
        averageVoteView.addSubview(averageVoteLabel)
        movieImageViewContainerView.addSubview(bottomTitleView)
        bottomTitleView.addSubview(bottomTitleLabel)
    }

    override func setupLayout() {
        super.setupLayout()
        
        movieContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        movieStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        movieImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        averageVoteView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
            make.size.equalTo(32)
        }
        averageVoteLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        bottomTitleView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(30)
        }
        bottomTitleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(6)
        }
    }

    //MARK: - Methods
    func setCell(with model: Results?) {
        guard let model = model else { return }
        averageVoteLabel.text = "\(model.voteAverage ?? 0.0)"
        bottomTitleLabel.text = model.name

        //MARK: - Fetch Images
        guard let posterPath = model.posterPath else {
            self.titleLabel.isHidden = false
            self.titleLabel.text = model.name
            self.bottomTitleView.isHidden = true
            return
        }
        let url = APIConstants.imageBaseUrl + posterPath
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.movieImageView.kf.setImage(
                with: URL(string: url),
                placeholder: nil,
                options: [.cacheOriginalImage],
                progressBlock: nil
            ) { result in
                switch result {
                case .success(_):
                    self.titleLabel.isHidden = true
                    self.bottomTitleView.isHidden = false
                case .failure(_):
                    self.titleLabel.isHidden = false
                    self.titleLabel.text = model.name
                    self.bottomTitleView.isHidden = true
                }
            }
        }
    }
    
}
