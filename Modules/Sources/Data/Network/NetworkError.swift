//
//  NetworkError.swift
//  
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation

enum NetworkError: Error {
    case unknown
    case invalidRequest
    case invalidResponse
    case unauthorized
    case paymentRequired
    case jsonDecodingError(error: Error)
    case dataLoadingError(Int)
}
