//
//  HomeVcCollectionViewCell.swift
//  TMDB
//
//  Created by Huseyin Akcay on 2.02.2023.
//

import UIKit

class HomeVcCollectionViewCell: BaseCollectionViewCell {
    //MARK: - UI Components
    lazy private var movieContainerView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = .zero
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 7
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
        view.isSkeletonable = true
        return view
    }()

    lazy private var titleLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.font = UIFont(name: customFont, size: 16)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    //MARK: - Configure UI
    override func setupViews() {
        super.setupViews()

        contentView.addSubview(movieContainerView)
        movieContainerView.addSubview(movieStackView)
        movieImageViewContainerView.addSubview(movieImageView)
        movieImageViewContainerView.addSubview(titleLabel)
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
    }

    //MARK: - Methods
    func setCell() {
        movieImageView.image = Images.splashLogo.image
    }
    
}