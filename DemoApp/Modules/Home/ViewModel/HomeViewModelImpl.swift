//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Nik Dub on 06.07.2024.
//

import Foundation

class HomeViewModelImpl: HomeViewModel {
    @Published var dataSource: String?
    private var coordinator: any HomeCoordinator
    
    init(coordinator: any HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func start() {}
    
    func deleteGroup() {}
    
    func openDetailScreen() {}
}

enum HomeState {
    case idle
    case loading
    case updated
    case error
}
