//
//  BaseVC.swift
//  TMDB
//
//  Created by Huseyin Akcay on 1.02.2023.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()
    }

    func showAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(
            title: commonOk,
            style: .destructive
        ) { _ in
            completion()
        }
        alertController.addAction(alertAction)
        DispatchQueue.main.async {
            self.present(
                alertController,
                animated: true
            )
        }
    }

}

extension BaseVC {
    @objc open func setupViews() {}
    @objc open func setupLayout() {}
}
