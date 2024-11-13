//
//  Publisher+AssignNoRetain.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import Combine

extension Publisher where Self.Failure == Never {
    func assignNoRetain<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root
    ) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
