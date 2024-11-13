//
//  AdapterView.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 30.08.2024.
//

import SwiftUI

final class AdapterView<V: View>: UIView {
    // MARK: - Private Properties
    private var hostingController: UIHostingController<V>?
    
    // MARK: - Lifecycles
    init(rootView: V, frame: CGRect) {
        super.init(frame: frame)
        setupHosting(withRootView: rootView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    private func setupHosting(withRootView rootView: V) {
        hostingController = UIHostingController(rootView: rootView)
        hostingController?.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.flatMap { addSubview($0.view) }
        
        let constraints = [
            hostingController?.view.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            hostingController?.view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            hostingController?.view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            hostingController?.view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero)
        ]
        NSLayoutConstraint.activate(constraints.compactMap { $0 })
    }
    
    // MARK: - Public Methods
    func addChildController(_ controller: UIViewController) {
        hostingController.flatMap(controller.addChild)
        hostingController?.didMove(toParent: controller)
    }
}
