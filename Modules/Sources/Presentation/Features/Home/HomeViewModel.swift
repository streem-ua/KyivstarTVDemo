//
//  HomeViewModel.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Domain
import Core
import Combine

typealias Category = Domain.Category

final class HomeViewModel: ViewModel {
    
    // MARK: - Properties
    typealias DataSource = [SectionModel<Home.Section, Home.Item>]

    @Published var dataSource: DataSource = []
    unowned var templatesRepository: TemplatesRepository
    var cancellables = Set<AnyCancellable>()
    let logger = AppLogger.homeFeature
    init(templatesRepository: TemplatesRepository) {
        self.templatesRepository = templatesRepository
    }
    
    // MARK: - Public methods
    func fetchData() async throws {
        var promotions: [Promotion] = []
        var categories: [Category] = []
        var movies: [Asset] = []
        var liveChannels: [Asset] = []
        var epg: [Asset] = []
        
        async let categoriesTask = templatesRepository.fetchCategories()
        async let contentGroupsTask = templatesRepository.fetchContentGroups()
        async let promotionsTask = templatesRepository.fetchPromotions()
        
        let (promotionsResponse, categoriesResponse, contentGroupsResponse) = try await (promotionsTask, categoriesTask, contentGroupsTask)
        
        categories = categoriesResponse
        promotions = promotionsResponse
        
        contentGroupsResponse.forEach { group in
            switch group.type {
            case [.movie], [.series]:
                movies.append(contentsOf: group.assets)
            case [.liveChannel]:
                liveChannels.append(contentsOf: group.assets)
            case [.epg]:
                epg.append(contentsOf: group.assets)
            default:
                break
            }
        }
        let content = ContentModel(promotions: promotions,
                                   categories: categories,
                                   movies: movies,
                                   liveChannels: liveChannels,
                                   epg: epg)
        updateDataSource(with: content)
    }
    
    private func updateDataSource(with content: ContentModel) {
        var dataSource = DataSource()
        dataSource.append(contentsOf: [
            .init(section: .promotion, items: content.promotions.map { .promotion($0) }),
            .init(section: .category, items: content.categories.map { .category($0) }),
            .init(section: .movie, items: content.movies.map { .movie($0) }),
            .init(section: .liveChannel, items: content.liveChannels.map { .liveChannel($0) }),
            .init(section: .epg, items: content.epg.map { .epg($0) }),
        ])
        self.dataSource = dataSource
    }
}
