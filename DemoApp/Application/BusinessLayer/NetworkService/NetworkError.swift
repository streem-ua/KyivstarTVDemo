//
//  NetworkError.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 31.05.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case jsonDecodeError
}
