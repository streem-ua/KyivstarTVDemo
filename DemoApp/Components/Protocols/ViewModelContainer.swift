//
//  ViewModelContainer.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import Foundation

protocol ViewModelContainer: AnyObject {
    associatedtype ViewModel: BaseVM
    var viewModel: ViewModel? { get set }
    func setupViewModel()
}

extension ViewModelContainer where Self: BaseVC {
    func setupViewModel() {
        viewModel?.$isLoading
            .assignNoRetain(to: \.isLoading, on: self)
            .store(in: &subscriptions)
        
        viewModel?.$error
            .assignNoRetain(to: \.error, on: self)
            .store(in: &subscriptions)
    }
}
