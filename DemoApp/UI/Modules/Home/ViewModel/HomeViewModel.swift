//
//  HomeViewModel.swift
//  DemoApp
//
//  Created by Ihor on 26.07.2024.
//

import Combine
import Foundation

final class HomeViewModelImp: ObservableObject {
    var sectionViewModels: [Home.SectionViewModel] = []
    var buildUIPassthroughSubject = PassthroughSubject<[Home.SectionViewModel], Never>()
    var deleteSectionPassthroughSubject = PassthroughSubject<Home.SectionViewModel, Never>()
    
    @Published var showLoadingView: Bool = false
    @Published var showRefreshing: Bool = false
    @Published var errorText: String?
    
    var state: Home.UIState = .loading {
        didSet{
            updateState(state)
        }
    }
    
    private let promotionsUseCase: PromotionsUseCase
    private let categoryUseCase: CategoryUseCase
    private let contentGroupUseCase: ContentGroupsUseCase
    private var promotions: [Promotion] = []
    
    func numberOfPromotions() -> Int {
        return promotions.count
    }
    
    init(
        _ promotionsUseCase: PromotionsUseCase,
        _ categoryUseCase: CategoryUseCase,
        _ contentGroupUseCase: ContentGroupsUseCase
    ) {
        self.promotionsUseCase = promotionsUseCase
        self.categoryUseCase = categoryUseCase
        self.contentGroupUseCase = contentGroupUseCase
    }
    

    private func updateState(_ state: Home.UIState) {
        switch state {
        case .loading:
            showLoadingView = true
            errorText = nil
        case .refreshing:
            showRefreshing = true
            errorText = nil
        case .success(let models):
            showLoadingView = false
            showRefreshing = false
            errorText = nil
            buildUIPassthroughSubject.send(models)
        case .successDeletion(let model):
            showRefreshing = false
            deleteSectionPassthroughSubject.send(model)
            errorText = nil
        case .failure(let error):
            errorText = error.debugDescription
            showLoadingView = false
            showRefreshing = false
        }
    }
    
    private func fetchData() async throws -> [Home.SectionViewModel] {
            promotions = try await promotionsUseCase.execute()
            let categories = try await self.categoryUseCase.execute()
            let movieGroups = try await self.contentGroupUseCase.fetchMovies()
            let liveGroups = try await self.contentGroupUseCase.fetchLiveChannels()
            let epgGroups = try await self.contentGroupUseCase.fetchEPG()
            
            var tempSectionViewModels: [Home.SectionViewModel] = []
            
            tempSectionViewModels.append(Home.SectionViewModel(
                section: .promotions,
                items: promotions.map({ Home.Item.promotion($0) })
            ))
            
            tempSectionViewModels.append(Home.SectionViewModel(
                section: .categories,
                items: categories.map({ Home.Item.category($0) })
            ))
            
            movieGroups.forEach { group in
                tempSectionViewModels.append(
                    Home.SectionViewModel(
                        section: .movieGroup(group),
                        items: group.assets.map({ Home.Item.movie($0) })
                    ))
            }
            
            liveGroups.forEach { group in
                tempSectionViewModels.append(
                    Home.SectionViewModel(
                        section: .liveGroup(group),
                        items: group.assets.map({ Home.Item.live($0) })
                    ))
            }
            
            epgGroups.forEach { group in
                tempSectionViewModels.append(
                    Home.SectionViewModel(
                        section: .epgGroup(group),
                        items: group.assets.map({ Home.Item.epg($0) })
                    ))
            }
        return tempSectionViewModels
    }
    
//    MARK: - Actions
    func onViewDidLoad() {
        state = .loading
        Task(priority: .high) {
            do {
                sectionViewModels = try await fetchData()
                state = .success(sectionViewModels)
            } catch {
                state = .failure(Home.HomeError.somethingWrong)
            }
        }
    }
    
    func onDeleteSection(_ sectionViewModel: Home.SectionViewModel) {
        state = .refreshing
        self.sectionViewModels.removeAll(where: {$0.section == sectionViewModel.section})
        state = .successDeletion(sectionViewModel)
    }
    
    @objc func onRefreshAction() {
        state = .refreshing
        Task(priority: .high) {
            do {
                sectionViewModels = try await fetchData()
                state = .success(sectionViewModels)
            } catch {
                state = .failure(Home.HomeError.somethingWrong)
            }
        }
    }
    
    func onItemSelected(_ item: Home.Item) {
        
    }
}
