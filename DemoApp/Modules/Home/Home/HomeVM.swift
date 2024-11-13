//
//  HomeVM.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import Combine

protocol HomeVMDelegate: AnyObject {
    func homeVMDidOpenAssetDetails(_ viewModel: HomeVM, assetDetail: AssetDetail)
}

final class HomeVM: BaseVM, UseCasesConsumer {
    typealias UseCases = HasAssetsUseCases
    
    // MARK: - Public Properties
    @Published var promotionGroup: PromotionGroup?
    @Published var categoryGroup: CategoryGroup?
    @Published var assetGroups: [AssetGroup]?
    
    // MARK: - Private Properties
    @Published private var assetDetail: AssetDetail?
    private weak var delegate: HomeVMDelegate?
    
    // MARK: - Initialize
    init(useCases: UseCases, delegate: HomeVMDelegate) {
        super.init()
        self.useCases = useCases
        self.delegate = delegate
        
        bind()
        getData()
    }
    
    private func bind() {
        $assetDetail
            .sink { [weak self] assetDetail in
                guard let self, let assetDetail else { return }
                self.delegate?.homeVMDidOpenAssetDetails(self, assetDetail: assetDetail)
            }
            .store(in: &subscriptions)
    }
    
    // MARK: - Actions
    private func getData() {
        getPromotions()
        getCategories()
        getContentGroups()
    }
    
    private func getPromotions() {
        useCases.assets
            .getPromotionGroup()
            .assignTo(isLoading: \.isLoading, value: \.promotionGroup, error: \.error, on: self)
            .store(in: &subscriptions)
    }
    
    private func getCategories() {
        useCases.assets
            .getCategories()
            .assignTo(isLoading: \.isLoading, value: \.categoryGroup, error: \.error, on: self)
            .store(in: &subscriptions)
    }
    
    private func getContentGroups() {
        useCases.assets
            .getContentGroups()
            .assignTo(isLoading: \.isLoading, value: \.assetGroups, error: \.error, on: self)
            .store(in: &subscriptions)
    }
    
    func openAssetDetails() {
        useCases.assets
            .getAssetDetails()
            .assignTo(isLoading: \.isLoading, value: \.assetDetail, error: \.error, on: self)
            .store(in: &subscriptions)
    }
}
