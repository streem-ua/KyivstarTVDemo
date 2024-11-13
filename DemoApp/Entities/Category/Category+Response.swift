//
//  Category+Response.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import Foundation

extension Category {
    struct Response: Decodable {
        let id: Category.ID
        let name: String
        let image: URL
    }
}

extension Category {
    init(_ response: Response) {
        self.init(
            id: response.id,
            name: response.name,
            image: response.image
        )
    }
}
