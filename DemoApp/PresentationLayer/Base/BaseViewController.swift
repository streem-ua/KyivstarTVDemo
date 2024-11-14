//
//  BaseViewController.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 31.05.2024.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    
    func showNetworkErrorAlert(completionHandler: EmptyClosure? = nil, title: String, message: String) {
        let alert = ControllersFactory.networkErrorAlert(completionHandler: completionHandler, title: title, message: message).makeController()
        present(alert, animated: true)
    }
}
