//
//  Controller.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Foundation

protocol Controller: AnyObject {
    associatedtype ViewModelType: ViewModel
    init(viewModel: ViewModelType)
    func bindOutputs(with viewModel: ViewModelType)
}
