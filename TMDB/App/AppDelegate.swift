//
//  AppDelegate.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit
import SkeletonView

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        configureSkeletonView()

        let navigationController = UINavigationController(rootViewController: SplashViewController())
        configureWindow(navigationController: navigationController)

        return true
    }

    private func configureSkeletonView() {
        SkeletonAppearance.default.multilineHeight = 20
        SkeletonAppearance.default.multilineCornerRadius = 10
        SkeletonAppearance.default.tintColor = .red.withAlphaComponent(0.7)
    }

    private func configureWindow(navigationController: UINavigationController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

}
