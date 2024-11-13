//
//  ContentGroupsClient.swift
//  DemoApp
//
//  Created by Ihor on 27.07.2024.
//

import Foundation

protocol ContentGroupsClient {
    func getContentGroups() async throws -> [ContentGroupDTO]
    func getAssetDetails() async throws -> AssetDetailsResponseDTO
}

class ContentGroupsClientImp: ContentGroupsClient {
    func getContentGroups() async throws -> [ContentGroupDTO] {
        let response: [ContentGroupDTO] = try await ApiClient.get(APIEnpointURL.getContentGroups())
        return response
    }
    
    func getAssetDetails() async throws -> AssetDetailsResponseDTO {
        let response: AssetDetailsResponseDTO = try await ApiClient.get(APIEnpointURL.getAssetDetailsURL())
        return response
    }
}
