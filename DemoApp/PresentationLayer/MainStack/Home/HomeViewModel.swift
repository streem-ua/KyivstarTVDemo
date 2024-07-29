//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 01.06.2024.
//

import UIKit
import Combine

final class HomeViewModel {
    
    //MARK: - Properties
    
    @Published private(set) var dataSource = [HomeSectionModel]()
    @Published private(set) var destination: HomeViewModel.Destination?
    @Published private(set) var networkError: NetworkError?

    private let networService = NetworkService()
    
    //MARK: - Init
    
    init() {
        loadData()
    }
    
    //MARK: - OpenFunc
    
    func sectionType(section: Int) -> Home.Section {
        dataSource[section].section
    }
    
    func promotionsCount() -> Int {
        let count = dataSource.first(where: { $0.section == .promotions })?.items.count
        return count ?? 0
    }
    
    func didTapDell(section: Home.Section) {
        guard let index = dataSource.firstIndex(where: { $0.section == section }) else { return }
        dataSource.remove(at: index)
    }
    
    func didSelectItem(indexPath: IndexPath) {
        let model = DetailModel()
        destination = .detail(model: model)
    }
    
    //MARK: - Private
    
    private func loadData() {
        dataSource = []
        Task {
            do {
                try await loadPromotions()
                try await loadCategories()
                try await loadContentGroups()
            } catch {
                networkError = error as? NetworkError
            }
        }
    }
    
    private func loadContentGroups() async throws {
        let contentGroups = try await networService.contentGroups().homeSectionModels()
        dataSource += contentGroups
    }
    
    private func loadCategories() async throws {
        let categories = try await networService.categories().categoriesItemType()
        dataSource.append(categories)
    }
    
    private func loadPromotions() async throws {
        let categories = try await networService.promotions().sectionModel()
        dataSource.append(categories)
    }
}

//MARK: - Destination

extension HomeViewModel {
    enum Destination {
        case detail(model: DetailModel)
    }
}
