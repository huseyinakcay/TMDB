//
//  SplashViewController.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit
import SnapKit

class SplashViewController: BaseVC {
    //MARK: - Properties
    private let constants = Constants.Splash.self

    //MARK: - UI Components
    lazy private var welcomeLabelContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    lazy private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = constants.welcome
        label.font = UIFont(name: customFont, size: 48)
        return label
    }()

    lazy private var splashImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    lazy private var splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.splashLogo.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //Delay is not needed but i wanted to show splash for 1 sec.
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.checkConnection()
//        }
    }

    //MARK: - Configure UI
    override func setupViews() {
        super.setupViews()

        view.addSubview(welcomeLabelContainerView)
        welcomeLabelContainerView.addSubview(welcomeLabel)
        view.addSubview(splashImageContainerView)
        splashImageContainerView.addSubview(splashImageView)
    }

    override func setupLayout() {
        super.setupLayout()
        
        welcomeLabelContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        welcomeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        splashImageContainerView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabelContainerView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(splashImageContainerView.snp.width).multipliedBy(1.25)
        }
        splashImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    //MARK: - Methods
    private func checkConnection() {
        if Reachability.isConnectedToNetwork() {
            navigateToHome()
        } else {
            showAlert(
                title: commonError,
                message: APIError.noConnection.errorDescription
            ) {
                self.checkConnection()
            }
        }
    }

    private func navigateToHome() {
        let viewController = HomeViewController()
        navigationController?.setViewControllers([viewController], animated: true)
    }
}
