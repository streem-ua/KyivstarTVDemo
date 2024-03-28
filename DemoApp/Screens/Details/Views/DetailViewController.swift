//
//  DetailViewController.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import SwiftUI
import Combine

final class DetailViewController: UIViewController {
    private var detailView = DetailView()
    var viewModel = DetailViewModel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        viewModel.fetchAssetDetails()

        let hostingController = UIHostingController(rootView: detailView.environmentObject(viewModel))
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)

        viewModel.fetchAssetDetails()
    }
}

