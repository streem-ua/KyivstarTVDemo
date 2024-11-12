//
//  HomeNetworkRepository.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Combine

final class HomeNetworkRepository: PHomeNetworkRepository {
    // MARK: - Properties
    private let provider: PRequestManagerProvider = NetworkService.shared.requestManagerProvider
    // MARK: - Methods
    func getContentGroup() -> AnyPublisher<NetResult<[ContentGroup]?>, Never> {
        Future { [weak self] promise in
            guard let self else { return }
            Task {
                let result = await self.fetchContentGroup()
                promise(.success(result))
            }
        }
        .eraseToAnyPublisher()
    }
    func getPromotions() -> AnyPublisher<NetResult<[Promotion]?>, Never> {
        Future { [weak self] promise in
            guard let self else { return }
            Task {
                let result = await self.fetchPromotions()
                promise(.success(result))
            }
        }
        .eraseToAnyPublisher()
    }
    func getCategory() -> AnyPublisher<NetResult<[Category]?>, Never> {
        Future { [weak self] promise in
            guard let self else { return }
            Task {
                let result = await self.fetchCategory()
                promise(.success(result))
            }
        }
        .eraseToAnyPublisher()
    }
    // MARK: - Private methods
    private func fetchContentGroup() async -> NetResult<[ContentGroup]?> {
        await withCheckedContinuation { continuation in
            let endpoint: HomeEndpoint = .contentGroup { isSuccess, data in
                continuation.resume(returning: .init(isSuccess: isSuccess, data: data))
            }
            provider.sendRequest(endpoint, requestAsyncType: .async)
        }
    }
    private func fetchPromotions() async -> NetResult<[Promotion]?> {
        await withCheckedContinuation { continuation in
            let endpoint: HomeEndpoint = .promotions { isSuccess, data in
                continuation.resume(returning: .init(isSuccess: isSuccess, data: data))
            }
            provider.sendRequest(endpoint, requestAsyncType: .async)
        }
    }
    private func fetchCategory() async -> NetResult<[Category]?> {
        await withCheckedContinuation { continuation in
            let endpoint: HomeEndpoint = .category { isSuccess, data in
                continuation.resume(returning: .init(isSuccess: isSuccess, data: data))
            }
            provider.sendRequest(endpoint, requestAsyncType: .async)
        }
    }
}
