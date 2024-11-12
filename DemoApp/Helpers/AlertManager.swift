//
//  AlertManager.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import UIKit

struct AlertManager {
    static func showAlert(from viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        viewController.present(alert, animated: true, completion: nil)
    }
}
