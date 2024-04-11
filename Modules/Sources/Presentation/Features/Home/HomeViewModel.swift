//
//  HomeViewModel.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Domain
import Core

final class HomeViewModel: ViewModel {
    
    // MARK: - Properties
    unowned var templatesRepository: TemplatesRepository
    let logger = AppLogger.homeFeature
    @Published var error: Error?
    
    init(templatesRepository: TemplatesRepository) {
        self.templatesRepository = templatesRepository
    }
    
    // MARK: - Public methods
    func fetchData() async throws {
        try await templatesRepository.fetchAssetDetails()
        try await templatesRepository.fetchCategories()
        try await templatesRepository.fetchContentGroups()
        try await templatesRepository.fetchPromotions()
    }
}
