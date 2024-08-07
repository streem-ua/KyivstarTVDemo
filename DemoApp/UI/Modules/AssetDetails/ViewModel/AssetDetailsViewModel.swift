//
//  AssetDetailsViewModel.swift
//  DemoApp
//
//  Created by Ihor on 05.08.2024.
//

import Combine
import Foundation
import SwiftUI

class AssetDetailsViewModel: ObservableObject {
    @Published var state: AssetDetailsModels.UIState = .loading
    @Published var assetDetails: AssetDetails?
    
    private var cancellable = Set<AnyCancellable>()
    let assetUseCase: ContentGroupsUseCase
    
    init(assetUseCase: ContentGroupsUseCase) {
        self.assetUseCase = assetUseCase
    }
    
    func onViewDidiLoad() {
        state = .loading
        Task {
            do {
                let details = try await self.assetUseCase.getchAssetDetails()
                await MainActor.run {
                    assetDetails = details
                    state = .success(details)
                }
            } catch {
                await MainActor.run {
                    state = .failure(.somethingWrong)
                }
            }
        }
    }
    
    deinit {
        print("AssetDetailsViewModel deinit")
    }
}
