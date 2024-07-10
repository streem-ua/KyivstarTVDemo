//
//  HomeProtocols.swift
//  DemoApp
//
//  Created by Nik Dub on 06.07.2024.
//

import Combine

protocol HomeViewModel {
    func start()
    func deleteGroup()
    func openDetailScreen()
}

protocol HomeView {
    var viewModel: HomeViewModel! { get set }
    func bindToPublisher(_ publisher: AnyPublisher<String, Never>)
}
