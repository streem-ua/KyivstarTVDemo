//
//  ContentGroupsUseCase.swift
//  DemoApp
//
//  Created by Ihor on 27.07.2024.
//

import Foundation

protocol ContentGroupsUseCase {
    func getchAssetDetails() async throws -> AssetDetails
    func fetchLiveChannels() async throws -> [ContentGroup]
    func fetchMovies() async throws -> [ContentGroup]
    func fetchEPG() async throws -> [ContentGroup]
    func deleteGroup(_ group: ContentGroup) async throws
}

final class ContentGroupsUseCaseImp: ContentGroupsUseCase {
    let contentGroupsClient: ContentGroupsClient
    let contentGroupsDAO: ContentGroupsDAO
    
    init(_ contentGroupsClient: ContentGroupsClient, _ contentGroupsDAO: ContentGroupsDAO) {
        self.contentGroupsClient = contentGroupsClient
        self.contentGroupsDAO = contentGroupsDAO
    }
    
    func fetchLiveChannels() async throws -> [ContentGroup] {
        var groups = try await loadAvailableGroupsIfNeeded()
        let resultGroups = groups.filter({ $0.type.contains(.live) })
        return resultGroups
    }
    
    func fetchMovies() async throws -> [ContentGroup] {
        var groups = try await loadAvailableGroupsIfNeeded()
        let resultGroups = groups.filter({ $0.type.contains(.series) })
        return resultGroups
    }
    
    func fetchEPG() async throws -> [ContentGroup] {
        var groups = try await loadAvailableGroupsIfNeeded()
        let resultGroups = groups.filter({ $0.type.contains(.epg) })
        return resultGroups
    }
    
    func getchAssetDetails() async throws -> AssetDetails {
        let detailsDTO = try await contentGroupsClient.getAssetDetails()
        return AssetDetails(detailsDTO)
    }
    
    func deleteGroup(_ group: ContentGroup) async throws {
        contentGroupsDAO.delete(group)
    }
}

fileprivate extension AssetDetails {
     init(_ dto: AssetDetailsResponseDTO) {
         self.id = dto.id
         self.name = dto.name
         self.description = dto.description
         self.image = dto.image
    }
}

extension ContentGroupsUseCaseImp {
    fileprivate func loadAvailableGroupsIfNeeded() async throws -> [ContentGroup] {
        var groups = contentGroupsDAO.get()
        if !groups.isEmpty {
            return groups
        }
        
        let promotionsDTO = try await contentGroupsClient.getContentGroups()
        groups = promotionsDTO.map { dto in
            return ContentGroup(dto: dto)
        }
        
        let availableGroups = groups
            .filter({ !$0.hidden })
            .filter({ !$0.type.contains(.no_diaplay) })
        
        return availableGroups
    }
}

private extension ContentGroup {
    init(dto: ContentGroupDTO) {
        self.id = dto.id
        self.name = dto.name
        self.type = dto.type.compactMap({ GroupType(rawValue: $0) })
        self.assets = dto.assets.compactMap({ Asset(dto: $0) })
        self.hidden = dto.hidden
        self.canBeDeleted = dto.canBeDeleted
    }
}

private extension Asset {
    init(dto: ContentGroupDTO.AssetDTO) {
        self.id = dto.id
        self.name = dto.name
        self.image = dto.image
        self.progress = dto.progress
        self.purchased = dto.purchased
        self.sortIndex = dto.sortIndex
    }
}
