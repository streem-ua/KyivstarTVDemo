//
//  NetworkService.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

class NetworkService {
    private let baseURL = URL(string: "https://api.json-generator.com/templates/")!
    private let token = "vf9y8r25pkqkemrk21dyjktqo7rs751apk4yjyrl"

    enum Endpoint: String {
        case promotions = "j_BRMrbcY-5W/data"
        case categories = "eO-fawoGqaNB/data"
        case contentGroups = "PGgg02gplft-/data"
        case assetDetails = "04Pl5AYhO6-n/data"
    }

    private func requestData<T: Decodable>(from endpoint: Endpoint) async throws -> T {
        let url = baseURL.appendingPathComponent(endpoint.rawValue)
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }

    func getPromotions() async throws -> PromotionsResponse {
        return try await requestData(from: .promotions)
    }

    func getCategories() async throws -> CategoriesResponse {
        return try await requestData(from: .categories)
    }

    func getContentGroups() async throws -> ContentGroupsResponse {
        return try await requestData(from: .contentGroups)
    }

    func getAssetDetails() async throws -> AssetDetails {
        return try await requestData(from: .assetDetails)
    }
}
