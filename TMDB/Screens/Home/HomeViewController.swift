//
//  HomeViewController.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit
import SnapKit
import SkeletonView

class HomeViewController: BaseVC {
    //MARK: - Properties

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

    var test = false
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "TMDB"
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
}

extension HomeViewController: SkeletonCollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        "HomeVcCollectionViewCell"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVcCollectionViewCell", for: indexPath) as! HomeVcCollectionViewCell
        if test {
            cell.setCell()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.main.bounds.width - 60) / 2
        let height: CGFloat = width * 1.5
        return CGSize(width: width, height: height)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    }

}
