//
//  Cancellable.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

protocol Cancellable {
    var isCancelled: Bool { get }
    func cancel()
}

final class CancellableToken: Cancellable {
    // MARK: - Private Properties
    private let token: AtomicBool = false
    private var didCancelClosure: (() -> Void)?

    // MARK: - Public Properties
    var isCancelled: Bool {
        token.value
    }

    // MARK: - Public Methods
    func cancel() {
        token.value = true
        didCancelClosure?()
    }

    func didCancel(_ action: @escaping () -> Void) {
        didCancelClosure = action
    }
}
