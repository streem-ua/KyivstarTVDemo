//
//  HomeViewController.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController, Viewable {

    let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let helloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupViews()
        setupConstraints()
    }

    private func setupViews() {

        helloLabel.text = "Welcome to KyivstarTV test app!"
        view.addSubview(helloLabel)

    }

    private func setupConstraints() {

        helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true

    }

}

