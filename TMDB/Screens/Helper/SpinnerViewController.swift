//
//  SpinnerViewController.swift
//  TMDB
//
//  Created by Huseyin Akcay on 3.02.2023.
//

import UIKit

final class SpinnerViewController: UIViewController {
    private var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = .red.withAlphaComponent(0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
