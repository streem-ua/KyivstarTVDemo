//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Combine
import UIKit

enum HomeTransition {
    case showDetails(Home.Item)
}

class HomeViewModel {
    typealias DataSource = [SectionModel<Home.Section, Home.Item>]

    var onTransition: ((HomeTransition) -> Void)?

    private var promotions: [Promotion] = []
    private var categories: [Category] = []
    private var movies: [Asset] = []
    private var liveChannels: [Asset] = []
    private var epg: [Asset] = []

    @Published var dataSource: DataSource = []
    private var closedSections: [Home.Section] = []

    private let networkService: NetworkService

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }

    private func updateDataSource() {
        var dataSource = DataSource()
        addLoadingItemIfNeeded(to: .promotions, data: promotions.map { .promotion($0) })
        addLoadingItemIfNeeded(to: .categories, data: categories.map { .category($0) })
        addLoadingItemIfNeeded(to: .movies, data: movies.map { .movie($0) })
        addLoadingItemIfNeeded(to: .liveChannel, data: liveChannels.map { .liveChannel($0) })
        addLoadingItemIfNeeded(to: .epg, data: epg.map { .epg($0) })

        self.dataSource = dataSource

        func addLoadingItemIfNeeded(to section: Home.Section, data: [Home.Item]) {
            guard !closedSections.contains(section) else { return }
            let loadingItems = (0..<10).map { _ in Home.Item.loading(UUID().uuidString) }
            dataSource.append(.init(section: section, items: data.isEmpty ? loadingItems : data))
        }
    }

    func deleteSection(_ section: Home.Section) {
        closedSections.append(section)
        updateDataSource()
    }

    func didSelectItem(_ item: Home.Item) {
        onTransition?(.showDetails(item))
    }

    func vibrate() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }

    // MARK: - Networking
    func fetchItems() {
        updateDataSource()
        Task(priority: .high) {
            do {
                async let promotionsResult = networkService.getPromotions()
                async let categoriesResult = networkService.getCategories()
                async let contentGroupsResult = networkService.getContentGroups()

                let (promotionsResponse, categoriesresponse, contentGroupsResponse) = try await (promotionsResult, categoriesResult, contentGroupsResult)

                self.promotions = promotionsResponse.promotions
                self.categories = categoriesresponse.categories

                contentGroupsResponse.forEach { contentGroup in
                    switch contentGroup.type {
                    case [.movie], [.series]:
                        movies.append(contentsOf: contentGroup.assets)
                    case [.liveChannel]:
                        liveChannels.append(contentsOf: contentGroup.assets)
                    case [.epg]:
                        epg.append(contentsOf: contentGroup.assets)
                    default:
                        break
                    }
                }
            } catch {
                print(error.localizedDescription)
            }

            updateDataSource()
        }
    }
}
