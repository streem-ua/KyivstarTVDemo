//
//  DetailsViewModel.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Domain

final class DetailsViewModel: ViewModel {
    
    private unowned var templatesRepository: TemplatesRepository
    @Published var assetDetails: AssetDetails?
    @Published var isPlaying = false
    @Published var isFavourite = false
   
    init(templatesRepository: TemplatesRepository) {
        self.templatesRepository = templatesRepository
    }
    
    func fetchData() async throws {
        let assetDetails = try await templatesRepository.fetchAssetDetails()
        
        DispatchQueue.main.async { [weak self] in
            self?.assetDetails = assetDetails
        }
    }
}



