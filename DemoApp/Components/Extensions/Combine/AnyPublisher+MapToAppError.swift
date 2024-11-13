//
//  AnyPublisher+MapToAppError.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import NetworkLayer
import Combine

extension AnyPublisher where Failure == NetworkError {
    func mapToAppError() -> AnyPublisher<Output, AppError> {
        mapError(AppError.network).eraseToAnyPublisher()
    }
}
