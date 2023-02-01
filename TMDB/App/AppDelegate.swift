//
//  AppDelegate.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = HomeViewController()
        window.makeKeyAndVisible()
        self.window = window
        return true
    }

}

