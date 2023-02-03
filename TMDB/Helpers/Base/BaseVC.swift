//
//  BaseVC.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit

class BaseVC: UIViewController {

#if DEBUG
    deinit {
        print("OS reclaiming memory for: \(self.classForCoder)")
    }
#endif
    private var spinner: SpinnerViewController? = SpinnerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()
        changeNavBarFont()
    }

    final func showAlert(
        title: String,
        message: String,
        completion: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(
            title: commonOk,
            style: .destructive
        ) { _ in
            completion?()
        }
        alertController.addAction(alertAction)
        DispatchQueue.main.async {
            self.present(
                alertController,
                animated: true
            )
        }
    }

    final func createSpinnerView() {
        guard let spinner = spinner else {
            return
        }
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }

    final func removeSpinnerView() {
        guard let spinner = spinner else { return }
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
        self.spinner = nil
    }

    func setupViews() {}
    func setupLayout() {}
    func changeNavBarFont() {
        navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.font: UIFont(name: commonFont, size: 20)!]
    }
}
