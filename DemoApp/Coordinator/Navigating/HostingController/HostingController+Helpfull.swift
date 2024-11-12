//
//  HostingController+Helpfull.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

extension HostingController {
    @discardableResult
    func setNavigationBarHidden(_ isHidden: Bool, animated: Bool = true) -> Self {
        config.navigationBar = .init(isHidden: isHidden, animated: animated)
        return self
    }
}
