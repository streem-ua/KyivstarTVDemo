//
//  Environment.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

extension Environment {
    var baseURL: URL {
        guard let url = URL(string: Environment.current.baseURLString) else {
            fatalError("Base URL is not valid")
        }
        return url
    }
}
