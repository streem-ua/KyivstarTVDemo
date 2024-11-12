//
//  HostingController.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

final class HostingController<Content> : UIHostingController<Content> where Content : View {
    // MARK: - Properties
    var config = Config()
    var didMovingFromParent: (() -> Void)?
    // MARK: - Override methods
    override func loadView() {
        super.loadView()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        if let color = config.backgroundColor {
            view.backgroundColor = color
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationBar = config.navigationBar {
            navigationController?.setNavigationBarHidden(
                navigationBar.isHidden, animated: navigationBar.animated
            )
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            didMovingFromParent?()
        }
    }
}


