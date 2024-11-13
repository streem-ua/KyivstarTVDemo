//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    typealias Collection = HomeViewController.Collection
    typealias CollectionStatus = Collection.Status
    typealias SectionModel = Collection.SectionModel
    typealias SectionItem = Collection.Item

    let promotionsViewModel: HomePromotionsViewModel = HomePromotionsViewModel()
    private(set) var sectionModels: [SectionModel] = []

    @Published private(set) var viewStatus: CollectionStatus = .idl
    public let viewActionsSubject = PassthroughSubject<HomeViewAction, Never>()
    public let viewEventsSubject = PassthroughSubject<HomeViewEvent, Never>()
    private var cancellable = Set<AnyCancellable>()

    //--
    private let apiService: HomeAPIService
 
    // MARK: - Init
    init(apiService: HomeAPIService = HomeAPIServiceImpl()) {
        self.apiService = apiService
        internalBinding()
    }
    
    func groupItem(for indexPath: IndexPath) -> ContentGroup.Asset? {
        guard let collectionItem = sectionModels[safe: indexPath.section]?.items[safe: indexPath.row] else { return nil }
      
        switch collectionItem {
        case .epg(let model), .liveChannel(let model), .movieSeries(let model):
            return model
        case .category, .promotion:
            return nil
        }
    }
    
    // MARK: - Binding
    private func internalBinding() {
        viewActionsSubject.sink { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .deleteSection(let sectionModel):
                guard let deletedSectionIndex = self.sectionModels.firstIndex(of: sectionModel) else { return }

                self.sectionModels.remove(at: deletedSectionIndex)
                self.viewStatus = .loaded(self.sectionModels)
            case .refreshContent:
                self.viewStatus = .refresh
                self.runDataTask()
            }
        }.store(in: &cancellable)
        
        viewEventsSubject.sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .viewDidLoad:
                self.viewStatus = .loading
                self.runDataTask()
            }
        }.store(in: &cancellable)
    }
    
    // MARK: - Private
    private func runDataTask() {
        Task {
            do {
                try await self.loadData()
            } catch {
                self.viewStatus = .error(error)
            }
        }
    }
    
    private func loadData() async throws {
        var sections: [SectionModel] = []

        //async let
        let (promotions, categories, contentGroups) = await (try loadPromotions(),
                                                             try loadCategories(),
                                                             try loadContentGroups())
        //Promotions
        let promotionItems = promotions.promotions.compactMap { SectionItem.promotion($0) }
        let promotionSection = SectionModel(section: .promotions, items: promotionItems)
        sections.append(promotionSection)
        
        promotionsViewModel.updatePromotions(promotionItems)

        //Categories
        let categoriesItems = categories.categories.compactMap { SectionItem.category($0)}
        let categoriesSection = SectionModel(section: .categories, items: categoriesItems)
        sections.append(categoriesSection)

        //Moview & Series
        let movieSeriesItems = contentGroups
            .filter { $0.type.contains(.series) || $0.type.contains(.movie)}
            .compactMap{ $0.assets }
            .joined()
            .compactMap({ SectionItem.movieSeries($0)})
        let movieSeriesSection = SectionModel(section: .movieSeriesGroup, items: movieSeriesItems)
        sections.append(movieSeriesSection)

        // LiveChannels
        let liveChannelsItems = contentGroups
            .filter { $0.type.contains(.liveChannels) }
            .compactMap { $0.assets }
            .joined()
            .compactMap { SectionItem.liveChannel($0) }
        let liveChannelsSection = SectionModel(section: .liveChannesGroup, items: liveChannelsItems)
        sections.append(liveChannelsSection)
        
        let epgItems = contentGroups
            .filter { $0.type.contains(.epg) }
            .compactMap { $0.assets }
            .joined()
            .compactMap { SectionItem.epg($0) }
        let epgSection = SectionModel(section: .epgGroup, items: epgItems)
        sections.append(epgSection)
        
        //Update
        sectionModels = sections
        viewStatus = .loaded(sections)
    }
    
    // MARK: - Working with loading data
    private func loadPromotions() async throws -> PromotionsResponse {
        try await apiService.getPromotions()
    }
    
    private func loadCategories() async throws -> CategoriesResponse {
        try await apiService.getCategories()
    }
    
    private func loadContentGroups() async throws -> [ContentGroup] {
        try await apiService.getContentGroups()
    }
}
