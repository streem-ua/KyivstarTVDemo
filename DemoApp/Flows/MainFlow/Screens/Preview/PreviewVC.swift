//
//  ViewController.swift
//  DemoApp
//
//  Created by Pete Shpagin on 31.03.2021.
//

import Combine
import UIKit

final class PreviewVC: UIViewController {
    // MARK: - UI
    private let helloLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    private lazy var openHomeScreenButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(openHomeScreenTapped), for: .touchUpInside)
        button.setTitle("Open Home Screen", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    // MARK: - Properties
    private var cancellable = Set<AnyCancellable>()
    private let network: PDetailsNetworkRepository = DetailsNetworkRepository()
    // MARK: - Navigation Properties
    var openNext: PassthroughSubject<Void, Never>?
    // MARK: - Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
    }
    // MARK: - Private methods
    private func setupViews() {
        helloLabel.text = "Welcome to KyivstarTV test app!"
        view.addSubview(helloLabel)
        view.addSubview(openHomeScreenButton)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            openHomeScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openHomeScreenButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30)
        ])
    }
     @objc private func openHomeScreenTapped() {
         openNext?.send()
    }
}

