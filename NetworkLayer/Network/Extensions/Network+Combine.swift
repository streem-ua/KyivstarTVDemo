//
//  Network+Combine.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Combine

extension Network {
    public func request(
        _ request: RequestConvertible,
        qos: DispatchQoS.QoSClass = .default
    ) -> AnyPublisher<Network.Response, NetworkError> {
        Future<Network.Response, NetworkError>({ [weak self] promise in
            self?.request(request, qos: qos) { result in
                switch result {
                case .success(let response):
                    promise(.success(response))
                case .failure(let error):
                    promise(.failure(NetworkError(error)))
                }
            }
        }).eraseToAnyPublisher()
    }
}
