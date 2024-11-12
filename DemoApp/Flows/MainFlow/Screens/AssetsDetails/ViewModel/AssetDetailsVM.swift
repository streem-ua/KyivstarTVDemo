//
//  AssetDetailsVM.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import Combine
import Foundation

final class AssetDetailsVM: PAssetDetailsVM {
    // MARK: - Properties
    let viewDidLoad = PassthroughSubject<Void, Never>()
    var backAction = PassthroughSubject<Void, Never>()
    @Published var showError: Bool = false
    @Published private(set) var assetDetail: AssetDetails?
    private var cancellable = Set<AnyCancellable>()
    private let repository: PDetailsNetworkRepository
    // MARK: - Init
    init(repository: PDetailsNetworkRepository) {
        self.repository = repository
        bind()
    }
    // MARK: - Private methods
    private func bind() {
        viewDidLoad
            .sink { [weak self] in
                self?.fetchAssetDetail()
            }
            .store(in: &cancellable)
    }
    private func fetchAssetDetail() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            let assets = await repository.getAssetsDetails()
            if assets.isSuccess, let data = assets.data {
                assetDetail = data
            } else {
                showError = true
            }
        }
    }
}
