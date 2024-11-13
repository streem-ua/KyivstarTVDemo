//
//  Publisher+HandleEvents.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import Combine

extension Publisher where Failure == AppError {
    func assignTo<Root>(
        isLoading: ReferenceWritableKeyPath<Root, Bool>? = nil,
        value: ReferenceWritableKeyPath<Root, Self.Output?>? = nil,
        error: ReferenceWritableKeyPath<Root, Error?>? = nil,
        on object: Root
    ) -> AnyCancellable where Root: AnyObject {
        handleEvents { _ in
            guard let isLoading = isLoading else { return }
            object[keyPath: isLoading] = true
        } receiveCancel: {
            guard let isLoading = isLoading else { return }
            object[keyPath: isLoading] = false
        } receiveRequest: { _ in
            guard let isLoading = isLoading else { return }
            object[keyPath: isLoading] = true
        }
        .sink { completion in
            isLoading.flatMap {
                object[keyPath: $0] = false
            }
            guard case let .failure(fail) = completion, let error = error else { return }
            object[keyPath: error] = fail
        } receiveValue: {
            guard let value = value else { return }
            object[keyPath: value] = $0
        }
    }
}
