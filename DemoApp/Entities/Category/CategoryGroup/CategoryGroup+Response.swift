//
//  CategoryGroup+Response.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import Foundation

extension CategoryGroup {
    struct Response: Decodable {
        let categories: [Category.Response]
    }
}

extension CategoryGroup {
    init(_ response: Response) {
        self.init(categories: response.categories.map(Category.init))
    }
}
