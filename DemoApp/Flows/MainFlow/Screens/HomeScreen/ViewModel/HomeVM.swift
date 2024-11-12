//
//  HomeVM.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Combine
import Foundation

final class HomeVM: PHomeVM {
    struct Input: PHomeVMInput {
        let viewDidLoad: PassthroughSubject<Void, Never>
        let didDeleteSection: PassthroughSubject<HomeViewAdapter.SectionType, Never>
        let didBeginRefreshing: PassthroughSubject<Void, Never>
        var didSelectAsset: PassthroughSubject<Void, Never>
    }
    struct Output: PHomeVMOutput {
        let sectionData: AnyPublisher<[SectionData], Never>
        let onDeleteSection: AnyPublisher<HomeViewAdapter.SectionType, Never>
        let viewStateOutput: AnyPublisher<ViewState, Never>
    }
    lazy var input: Input = .init(
        viewDidLoad: viewDidLoad,
        didDeleteSection: didDeleteSection,
        didBeginRefreshing: didBeginRefreshing,
        didSelectAsset: didSelectAsset
    )
    lazy var output: Output = .init(
        sectionData: sectionDataModel,
        onDeleteSection: onDeleteSection,
        viewStateOutput: viewStateOutput
    )
    // Input
    private let viewDidLoad = PassthroughSubject<Void, Never>()
    private let didDeleteSection = PassthroughSubject<HomeViewAdapter.SectionType, Never>()
    private let didBeginRefreshing = PassthroughSubject<Void, Never>()
    private let didSelectAsset = PassthroughSubject<Void, Never>()
    // Output
    private var sectionDataModel: AnyPublisher<[SectionData], Never> { $sectionData.eraseToAnyPublisher() }
    private var onDeleteSection: AnyPublisher<HomeViewAdapter.SectionType, Never> { onDeleteSectionSubject.eraseToAnyPublisher() }
    private var viewStateOutput: AnyPublisher<ViewState, Never> { $viewState.eraseToAnyPublisher() }
    // MARK: - Publishers
    @Published private var sectionData: [SectionData] = []
    @Published private var viewState: ViewState = .showLoading(true)
    private let onDeleteSectionSubject = PassthroughSubject<HomeViewAdapter.SectionType, Never>()
    // MARK: - Properties
    private var internalSectionData: [SectionData] = []
    private var cancellable = Set<AnyCancellable>()
    private let repository: PHomeNetworkRepository
    // MARK: - Init
    init(repository: PHomeNetworkRepository) {
        self.repository = repository
        bind()
    }
    // MARK: - Private methods
    private func bind() {
        input.viewDidLoad
            .sink { [weak self] in
                self?.fetchData()
            }
            .store(in: &cancellable)
        input.didDeleteSection
            .sink { [weak self] in
                self?.deleteSection($0)
            }
            .store(in: &cancellable)
        input.didBeginRefreshing
            .sink { [weak self] in
                self?.fetchData()
            }
            .store(in: &cancellable)
    }
    private func fetchData() {
        viewState = .showLoading(true)
        let promotionsPublisher = fetchDataGeneric(endpoint: repository.getPromotions())
        let categoriesPublisher = fetchDataGeneric(endpoint: repository.getCategory())
        let contentGroupsPublisher = fetchDataGeneric(endpoint: repository.getContentGroup())
        Publishers.CombineLatest3(promotionsPublisher, categoriesPublisher, contentGroupsPublisher)
            .map { [weak self] promotionsResult, categoriesResult, contentGroupsResult in
                guard let self else { return [] }
                handleShowError([
                    promotionsResult.isSuccess,
                    categoriesResult.isSuccess,
                    contentGroupsResult.isSuccess
                ])
                internalSectionData = sectionData
                viewState = .showLoading(false)
                return handleMapping(promotionsResult, categoriesResult, contentGroupsResult)
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$sectionData)
        
    }
    private func deleteSection(_ type: HomeViewAdapter.SectionType) {
        internalSectionData.removeAll(where: { $0.section == type} )
        onDeleteSectionSubject.send(type)
    }
    private func handleMapping(
        _ promotion: NetResult<[Promotion]>,
        _ categories: NetResult<[Category]>,
        _ contentGroup: NetResult<[ContentGroup]>
    ) -> [SectionData] {
        var sectionData: [SectionData] = []
        if promotion.isSuccess, let promotionsModel = promotion.data {
            let items = promotionsModel.map { HomeViewAdapter.SectionItem.promotions($0) }
            sectionData.append(SectionData(section: .promotions, items: items))
        }
        if categories.isSuccess, let categoriesModel = categories.data {
            let items = categoriesModel.map { HomeViewAdapter.SectionItem.categories($0) }
            sectionData.append(SectionData(section: .categories, items: items))
        }
        if contentGroup.isSuccess, let contentGroups = contentGroup.data {
            let movieSeriesItems = extractAssets(from: contentGroups, types: [.movie, .series]) { .movieSeries($0) }
            let liveChannelItems = extractAssets(from: contentGroups, types: [.liveChannel]) { .liveChannels($0) }
            let epgItems = extractAssets(from: contentGroups, types: [.epg]) { .epg($0) }
            // For Section MovieSeries
            let movieSeriesCanBeDeleted = contentGroups.contains { $0.type.contains(.movie) || $0.type.contains(.series) && ($0.canBeDeleted ?? false) }
            sectionData.append(SectionData(section: .movieSeries, items: movieSeriesItems, canBeDeleted: movieSeriesCanBeDeleted))
            // For Section LiveChannels
            let liveChannelsCanBeDeleted = contentGroups.contains { $0.type.contains(.liveChannel) && ($0.canBeDeleted ?? false) }
            sectionData.append(SectionData(section: .liveChannels, items: liveChannelItems, canBeDeleted: liveChannelsCanBeDeleted))
            // For Section EPG
            let epgCanBeDeleted = contentGroups.contains { $0.type.contains(.epg) && ($0.canBeDeleted ?? false) }
            sectionData.append(SectionData(section: .epg, items: epgItems, canBeDeleted: epgCanBeDeleted))
        }
        return sectionData
    }
    private func handleShowError(_ isSuccess: [Bool]) {
        if !isSuccess.allSatisfy({ $0 }) {
            viewState = .showAlert
        }
    }
    // MARK: - Generalized Data Fetching Method
    private func fetchDataGeneric<T>(endpoint: AnyPublisher<NetResult<[T]?>, Never>) -> AnyPublisher<NetResult<[T]>, Never> {
        endpoint
            .map { result in
                guard result.isSuccess, let data = result.data else {
                    return NetResult<[T]>(isSuccess: false, data: [])
                }
                return NetResult(isSuccess: true, data: data)
            }
            .eraseToAnyPublisher()
    }
    private func extractAssets(
        from contentGroups: [ContentGroup],
        types: [ContentGroup.ContentType],
        mapTo sectionItem: (ContentGroup.Asset) -> HomeViewAdapter.SectionItem
    ) -> [HomeViewAdapter.SectionItem] {
        contentGroups
            .filter { contentGroup in
                contentGroup.type.contains(where: { types.contains($0) })
            }
            .compactMap { $0.assets }
            .flatMap { $0 }
            .map { sectionItem($0) }
    }
}
