//
//  DetailViewModel.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import SwiftUI

class DetailViewModel: ObservableObject {
    private let networkService: NetworkService
    @Published var asset: AssetDetails?

    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }

    // MARK: - Networking
    func fetchAssetDetails() {
        Task(priority: .high) {
            do {
                let assetDetailsResult = try await networkService.getAssetDetails()
                DispatchQueue.main.async {
                    self.asset = assetDetailsResult
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
