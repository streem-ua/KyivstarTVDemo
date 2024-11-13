//
//  AssetDetailsViewController.swift
//  DemoApp
//
//  Created by Vlad Tkach on 17.08.2024.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class AssetDetailsViewController: UIViewController {
    private var detailView: AssetDetailsView
    
    private var cancellable = Set<AnyCancellable>()

    //MARK: - Init
    init(detailView: AssetDetailsView) {
        self.detailView = detailView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = detailView.asset.name
        view.backgroundColor = .systemBackground
        
        setupHostingController()
        bindHostingOutput()
    }
    
    // MARK: - View setup
    private func setupHostingController() {
        let hostingController = UIHostingController(rootView: detailView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false

        addChild(hostingController)
        view.addSubview(hostingController.view)
    
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    private func bindHostingOutput() {
        detailView.hostingOutputSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                switch action {
                case .dismiss:
                    self?.navigationController?.popViewController(animated: true)
                }
            }.store(in: &cancellable)
    }
}
