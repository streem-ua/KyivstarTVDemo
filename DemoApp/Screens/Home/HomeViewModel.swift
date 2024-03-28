//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

enum HomeTransition {
    case showDetails(Home.Item)
}

class HomeViewModel {
    var onTransition: ((HomeTransition) -> Void)?
}
