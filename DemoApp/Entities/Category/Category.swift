//
//  Category.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import Foundation

struct Category: Equatable, Hashable, Identifiable {
    let id: String
    let name: String
    let image: URL
}
