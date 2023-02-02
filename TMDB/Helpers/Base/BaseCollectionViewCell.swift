//
//  BaseCollectionViewCell.swift
//  TMDB
//
//  Created by Huseyin Akcay on 2.02.2023.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {}
    func setupLayout() {}
}
