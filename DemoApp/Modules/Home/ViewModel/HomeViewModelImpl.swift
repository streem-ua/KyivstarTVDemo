//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Nik Dub on 06.07.2024.
//

import Foundation
import Combine

typealias Category = CategoriesRequest.Category
typealias Promotion = PromotionsRequest.Promotion
typealias GroupsContent = ContentGroupsRequest.Response
typealias Asset = ContentGroupsRequest.Asset

class HomeViewModelImpl: HomeViewModel {
    @Published private var dataSource: HomeState = .idle
    private var coordinator: any HomeCoordinator
    
    private let group = DispatchGroup()
    private let serialQueue = DispatchQueue(label: "home.serial.queue")
    
    private var categories: [Category] = []
    private var promotions: [Promotion] = []
    private var contentGroups: [GroupsContent] = []
    
    init(coordinator: any HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func start() {
        loadData()
    }
    
    func subscribeOnPublished(block: (AnyPublisher<HomeState, Never>) -> ()) {
        block($dataSource.eraseToAnyPublisher())
    }
    
    func deleteGroup(at index: Int) {
        
    }
    
    func openDetailScreen() {
        
    }
    
    private func loadData() {
        dataSource = .loading
        serialQueue.async { [weak self] in
            guard let self = self else {
                self?.group.leave()
                return
            }
            self.group.enter()
            DIContainer.shared.apiService.contentGroups { result in
                switch result {
                case .success(let success):
                    self.contentGroups = success
                case .failure(let failure):
                    self.dataSource = .error(failure)
                }
                self.group.leave()
            }
            self.group.enter()
            DIContainer.shared.apiService.categories { result in
                switch result {
                case .success(let success):
                    self.categories = success.categories
                case .failure(let failure):
                    self.dataSource = .error(failure)
                }
                self.group.leave()
            }
            self.group.enter()
            DIContainer.shared.apiService.promotions { result in
                switch result {
                case .success(let success):
                    self.promotions = success.promotions
                case .failure(let failure):
                    self.dataSource = .error(failure)
                }
                self.group.leave()
            }
            group.notify(queue: serialQueue) {
                self.configureDataSource()
            }
        }
    }
    
    private func configureDataSource() {
        guard !self.categories.isEmpty,
              !self.promotions.isEmpty,
              !self.contentGroups.isEmpty else {
            return
        }
        let filtered = self.contentGroups.filter {
            SectionType(rawValue: $0.type.first ?? "") != nil
        }
        var expandedSections: [Section] = [
            Section(type: .PROMOTIONS, cellItems: promotions.map{ $0.toCellItem() }),
            Section(type: .CATEGORIES, cellItems: categories.map{ $0.toCellItem() })
        ]
        expandedSections += filtered.map {
            Section(
                type: SectionType(rawValue: $0.type.first!)!,
                cellItems: $0.assets.map { $0.toCellItem() }
            )
        }
        dataSource = .updated(expandedSections)
    }
}
