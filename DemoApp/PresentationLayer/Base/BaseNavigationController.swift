//
//  BaseNavigationViewController.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 31.05.2024.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    //MARK: - Configure
    
    private func configure() {
        navigationBar.isHidden = true
    }
}
