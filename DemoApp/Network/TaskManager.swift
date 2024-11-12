//
//  TaskManager.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

protocol PTaskManager {
    /**
     Provides interface for send serial request.
     
     - Parameters:
        - request: Closure capture updated text and replaced string.
        - requestTimeout: Request timeout, default value 15.0.
        - completion: Closure capture network result `NetworkResult`.
     */
    func sendSerialRequest(_ request: URLRequest) async -> NetworkResult
    /**
     Provides interface for send concurrent request.
     
     - Parameters:
        - request: Closure capture updated text and replaced string.
        - requestTimeout: Request timeout, default value 15.0.
        - completion: Closure capture network result `NetworkResult`.
     */
    func sendConcurrentRequest(_ request: URLRequest) async -> NetworkResult
}

extension PTaskManager {
    func sendSerialRequest(_ request: URLRequest) async -> NetworkResult {
        let someError = NSError(
            domain: "com.example.error",
            code: -1,
            userInfo: [NSLocalizedDescriptionKey: "This method is not implemented."]
        )
        return .error(someError)
    }
}

final class TaskManager: NSObject, URLSessionDelegate, PTaskManager {
    // MARK: - Public Properties
    static var shared: PTaskManager = TaskManager()
    static var baseUrl: URL { NetworkSecurityParameters.baseUrl }
    // MARK: - Private Properties
    private lazy var session: URLSession = {
        let sessionConfig = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: .main)
        return session
    }()
    // MARK: - Initializer
    private override init() {}
    // MARK: Send Request
    func sendConcurrentRequest(_ request: URLRequest) async -> NetworkResult {
        do {
            let (data, response) = try await session.data(for: request)
            return .success(data, response)
        } catch {
            return .error(error)
        }
    }
}
