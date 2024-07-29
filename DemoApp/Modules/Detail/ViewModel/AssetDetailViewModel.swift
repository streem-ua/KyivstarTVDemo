//
//  AssetDetailViewModel.swift
//  DemoApp
//
//  Created by Nik Dub on 11.07.2024.
//

import Foundation
import Combine

protocol DetailViewModel {
    func start()
    func subscribeOnPublisher(block: (AnyPublisher<DetailState, Never>) -> ())
}

class AssetDetailViewModel: DetailViewModel {
    @Published var state: DetailState = .idle
    func start() {
        
    }
    
    func subscribeOnPublisher(block: (AnyPublisher<DetailState, Never>) -> ()) {
        block($state.eraseToAnyPublisher())
    }
}

enum DetailState {
    case idle
    case loading
    case updated(DetailModel)
    case error(Error)
}

struct DetailModel {}


enum DetailRoute {
    case back
}
