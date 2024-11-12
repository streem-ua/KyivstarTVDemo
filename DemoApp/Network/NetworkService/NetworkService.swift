//
//  NetworkService.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Combine
import Foundation


final class NetworkService: PNetworkService {
    // MARK: - Init
    private init() {}
    // MARK: - Properties
    static var shared: PNetworkService = NetworkService()
    // Root
    var requestManagerProvider: PRequestManagerProvider { RequestManager() }
}
