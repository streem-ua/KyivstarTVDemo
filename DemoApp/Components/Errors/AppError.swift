//
//  AppError.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import NetworkLayer

enum AppError: Error {
    case network(error: NetworkError)
    case undefined
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        guard case .network(let error) = self else { return nil }
        return error.errorDescription
    }
}
