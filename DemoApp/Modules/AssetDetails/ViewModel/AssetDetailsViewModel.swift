//
//  AssetDetailsViewModel.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import SwiftUI
import Combine

class AssetDetailsViewModel: NSObject, ObservableObject {

    @Published var isShowSpinner = false
    
    @Published var assetDetails: AssetDetails?

    private var cancellables = Set<AnyCancellable>()
    
    private let homeService: HomeService

    init(homeService: HomeService = HomeService(httpClient: AuthenticatedHTTPClientDecorator(client: URLSession.shared))) {
        self.homeService = homeService
    }

    func getAssetDetails() {
        isShowSpinner = true

        homeService.getAssetDetails()
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { _ in self.isShowSpinner = false })
            .sink { completion in
                if case .failure(let error) = completion {
                    self.handleError(error)
                }
            } receiveValue: { [weak self] response in
                self?.assetDetails = response
            }
            .store(in: &cancellables)
    }

    private func handleError(_ error: Error) {
        if let apiError = error as? APIErrorHandler {
            print(apiError.errorDescription ?? "Unknown Error")
        } else {
            print(error.localizedDescription)
        }
    }

    func getDetails() -> String {
        guard let assetDetails else { return "" }

        var details = assetDetails.company

        let hours = assetDetails.duration / 60
        let minutes = assetDetails.duration % 60
        details.append(" · \(hours)h \(minutes)m")

        if let releaseYear = assetDetails.releaseDate.toYear() {
            details.append(" · \(releaseYear)")
        }

        return details
    }
}
