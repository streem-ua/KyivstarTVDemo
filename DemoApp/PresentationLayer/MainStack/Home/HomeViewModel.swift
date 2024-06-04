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
    var cancellables = Set<AnyCancellable>()
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
        let count = dataSource.first(where: {$0.section == .promotions})?.items.count
        return count ?? 0
    }
    
    func didTapDell(sectionIndex: Int) {
        dataSource.remove(at: sectionIndex)
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
                print(error)
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
