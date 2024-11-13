//
//  BaseAPI.swift
//  DemoApp
//
//  Created by Vlad Tkach on 14.08.2024.
//

import Foundation

class BaseAPI {

    let provider: NetworkServiceProvider
    
    init(provider: NetworkServiceProvider = NetworkServiceProviderImpl.shared) {
        self.provider = provider
    }
    
    func perform<T: Decodable>(request: GenericRequest) async throws -> T {
        return try await provider.perform(request)
    }

    //static func performMultipartFormData
}
