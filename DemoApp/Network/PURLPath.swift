//
//  PURLPath.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

protocol PURLPath {
    var baseUrl: URL? { get }
    var link: String { get }
}

extension PURLPath {
    var baseUrl: URL? { nil }
}
