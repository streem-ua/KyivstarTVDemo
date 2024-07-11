//
//  HomeProtocols.swift
//  DemoApp
//
//  Created by Nik Dub on 06.07.2024.
//

import Foundation
import Combine

protocol HomeViewModel {
    func start()
    func deleteGroup(with id: UUID)
    func openDetailScreen()
    func subscribeOnPublisher(block: (AnyPublisher<HomeState, Never>) -> ())
}

protocol HomeView {
    var viewModel: HomeViewModel! { get set }
}

enum HomeState {
    case idle
    case loading
    case updated([Section])
    case error(Error)
}

class CellItem {
    var id = UUID()
    var title: String?
    var subtitle: String?
    var imageURL: String?
    var progress: Float?
    var purchased: Bool?
}

extension CellItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: CellItem, rhs: CellItem) -> Bool {
        lhs.id == rhs.id
    }
}

extension Category {
    func toCellItem() -> CellItem {
        let item = CellItem()
        item.title = self.name
        item.imageURL = self.image
        return item
    }
}
extension Promotion {
    func toCellItem() -> CellItem {
        let item = CellItem()
        item.title = self.name
        item.imageURL = self.image
        return item
    }
}
extension Asset {
    func toCellItem() -> CellItem {
        let item = CellItem()
        item.title = self.name
        item.imageURL = self.image
        item.subtitle = self.company
        item.purchased = self.purchased
        return item
    }
}

enum SectionType: String {
    case MOVIE, SERIES, LIVECHANNEL, EPG, PROMOTIONS, CATEGORIES
}
