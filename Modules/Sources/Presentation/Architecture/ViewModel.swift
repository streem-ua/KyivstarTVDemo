//
//  ViewModel.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

// MARK: - Viewable
protocol Viewable {
    associatedtype T where T: ViewModel
    var viewModel: T { get }
}

// MARK: - ViewModel
protocol ViewModel: ObservableObject { }
