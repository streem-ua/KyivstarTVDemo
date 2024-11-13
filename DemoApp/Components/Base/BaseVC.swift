//
//  BaseVC.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import UIKit
import Combine
import NetworkLayer

class BaseVC: UIViewController {
    // MARK: - Constantes
    private enum C {
        static let activityAnimationDuration: TimeInterval = 0.25
    }
    
    // MARK: - Properties
    @Published var isLoading = false
    @Published var error: Error?
    var subscriptions: Set<AnyCancellable> = .init()
    
    // MARK: - Private properties
    private lazy var activityView = makeActivityView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupVC()
    }
    
    deinit {
        print("\(#function) \(self)")
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
    
    // MARK: - Public Methods
    func setupVC() {
        view.backgroundColor = .white
    }
    
    func bind() {
        $isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in $0 ? self?.showActivity() : self?.hideActivity() }
            .store(in: &subscriptions)
        
        $error
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] in self?.showErrorAlert($0) }
            .store(in: &subscriptions)
    }
    
    func showActivity(animated: Bool = true) {
        let duration: TimeInterval = animated ? C.activityAnimationDuration : 0
        UIView.animate(withDuration: duration, delay: .zero, options: .beginFromCurrentState) {
            self.activityView.alpha = 1.0
            self.activityView.isAnimating = true
        }
    }
    
    func hideActivity(animated: Bool = true) {
        let duration: TimeInterval = animated ? C.activityAnimationDuration : 0
        UIView.animate(withDuration: duration, delay: 0.0, options: .beginFromCurrentState) {
            self.activityView.alpha = 0.0
        }
    }
    
    func showErrorAlert(_ error: Error) {
        let controller = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
    
    // MARK: - Private Methods
    private func makeActivityView() -> ActivityView {
        let activity = ActivityView(frame: view.bounds)
        activity.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activity.alpha = 0
        view.addSubview(activity)
        return activity
    }
}
