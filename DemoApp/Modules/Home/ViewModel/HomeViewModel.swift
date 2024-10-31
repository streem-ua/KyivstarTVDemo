//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import Foundation
import Combine

class HomeViewModel {
    
    @Published private(set) var promotions: [Promotion] = []
    
    @Published private(set) var categories: [Category] = []
    
    @Published private(set) var series: [Asset] = []
    
    @Published private(set) var livechannels: [Asset] = []
    
    @Published private(set) var epgs: [Asset] = []
    
    @Published private(set) var snapshotItems: [Section: [Item]] = [:]

    private var sectionContentGroups: [Section: ContentGroup] = [:]

    private let homeService: HomeService
    
    private var cancellables = Set<AnyCancellable>()

    init(homeService: HomeService = HomeService(httpClient: AuthenticatedHTTPClientDecorator(client: URLSession.shared, tokenProvider: TokenProvider()))) {
        self.homeService = homeService
        fetchData()
    }

    private func fetchData() {
        let promotionsPublisher = homeService.getPromotions()
            .map { $0.promotions }
            .replaceError(with: [])
            .eraseToAnyPublisher()

        let categoriesPublisher = homeService.getCategories()
            .map { $0.categories }
            .replaceError(with: [])
            .eraseToAnyPublisher()

        let contentGroupsPublisher = homeService.getContentGroups()
            .map { self.filterAssets(from: $0) }
            .replaceError(with: ())
            .eraseToAnyPublisher()

        Publishers.Zip3(promotionsPublisher, categoriesPublisher, contentGroupsPublisher)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] promotions, categories, _ in
                self?.promotions = promotions
                self?.categories = categories
                self?.prepareSnapshot()
            }
            .store(in: &cancellables)
    }

    private func filterAssets(from contentGroups: ContentGroupResponseModel) {
        contentGroups.forEach { contentGroup in
            if contentGroup.type.contains(.series) {
                series.append(contentsOf: contentGroup.assets)
                sectionContentGroups[.series] = contentGroup
            }
            if contentGroup.type.contains(.livechannel) {
                livechannels.append(contentsOf: contentGroup.assets)
                sectionContentGroups[.livechannels] = contentGroup
            }
            if contentGroup.type.contains(.epg) {
                epgs.append(contentsOf: contentGroup.assets)
                sectionContentGroups[.epgs] = contentGroup
            }           
        }
    }

    private func prepareSnapshot() {
        snapshotItems[.promotions] = promotions.map { .promotion($0) }
        snapshotItems[.categories] = categories.map { .category($0) }
        snapshotItems[.series] = series.map { .series($0) }
        snapshotItems[.livechannels] = livechannels.map { .livechannel($0) }
        snapshotItems[.epgs] = epgs.map { .epg($0) }
    }

    func canDeleteSection(_ section: Section) -> Bool {
        return sectionContentGroups[section]?.canBeDeleted ?? false
    }

    func removeSection(_ section: Section) {
        sectionContentGroups[section] = nil
        snapshotItems[section] = nil
    }
}
