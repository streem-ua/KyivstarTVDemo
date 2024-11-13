//
//  AuthorizationPlugin.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Combine

public enum AuthorizationStrategy {
    case token
}

final public class AuthorizationPlugin: NetworkPlugin {
    // MARK: - Private Properties
    private var token: Token?
    private var cancellable: AnyCancellable?
    
    // MARK: - Life cycles
    public init() {}
    
    deinit {
        cancellable?.cancel()
        cancellable = nil
    }

    // MARK: - Public Methods
    public func setToken(_ token: Token?) {
        self.token = token
    }

    public func prepare(_ request: URLRequest, target: RequestConvertible) throws -> URLRequest {
        try with(request) {
            guard target.authorizationStrategy == .token else { return }
            guard let token else { throw NetworkError.sessionRequired }
            $0.headers.add(token.authorizationHeader)
        }
    }
}

