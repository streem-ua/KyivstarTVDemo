//
//  BaseVM.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import Combine

class BaseVM {
    @Published var isLoading = false
    @Published var error: Error?
    var subscriptions: Set<AnyCancellable> = []
    
    deinit {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}
