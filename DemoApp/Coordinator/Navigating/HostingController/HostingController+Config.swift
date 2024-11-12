//
//  HostingController+Config.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import UIKit

extension HostingController {
    struct Config {
        var navigationBar: NavigationBar?
        var backgroundColor: UIColor?
    }
}

extension HostingController.Config {
    struct NavigationBar {
        let isHidden: Bool
        let animated: Bool
    }
}
