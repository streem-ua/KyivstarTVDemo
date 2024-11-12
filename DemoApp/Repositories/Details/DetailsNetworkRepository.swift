//
//  DetailsNetworkRepository.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Foundation

final class DetailsNetworkRepository: PDetailsNetworkRepository {
    // MARK: - Properties
    private let provider: PRequestManagerProvider = NetworkService.shared.requestManagerProvider
    // MARK: - Methods
    func getAssetsDetails() async -> NetResult<AssetDetails?> {
        await withCheckedContinuation { continuation in
            let endpoint: DetailsEndpoint = .assetDetails { isSuccess, data in
                continuation.resume(returning: .init(isSuccess: isSuccess, data: data))
            }
            provider.sendRequest(endpoint, requestAsyncType: .async)
        }
    }
}
