//
//  ContentGroupsRequest.swift
//  DemoApp
//
//  Created by Nik Dub on 10.07.2024.
//

import Foundation

final class ContentGroupsRequest {
    
    // MARK: - Response -
    
    struct Response: Codable {
        let id, name: String
        let type: [String]
        let assets: [Asset]
        let hidden: Bool
        let sortIndex: Int
        let canBeDeleted: Bool
    }
    
    // MARK: - Asset -
    
    struct Asset: Codable {
        let id, name: String
        let image: String
        let company: String
        let progress: Int
        let purchased: Bool
        let sortIndex: Int
        let updatedAt, releaseDate: String
    }
    
    class Input: Encodable {
        
        let params: [String: String]
        let path: String
        
        init(path: String, params: [String: String]) {
            self.params = params
            self.path = path
        }
    }
    
    private let input: Input
    
    init() {
        input = Input(
            path: "PGgg02gplft-/data",
            params: ["Authorization": "Bearer vf9y8r25pkqkemrk21dyjktqo7rs751apk4yjyrl"]
        )
    }
}

extension ContentGroupsRequest: NetworkRequest {
    typealias Body = ContentGroupsRequest.Response
    
    var url: URL {
        return Environment.baseURL.appendingPathComponent(input.path)
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String: String] {
        return ["Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Bearer vf9y8r25pkqkemrk21dyjktqo7rs751apk4yjyrl"]
    }
    
    var params: [String: String] {
        return input.params
    }
    
    var body: Body? {
        return nil
    }
}
