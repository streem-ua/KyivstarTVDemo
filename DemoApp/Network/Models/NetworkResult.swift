//
//  NetworkResult.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

enum NetworkResult {
    case success(Data?, URLResponse?)
    case error(Error)
}
