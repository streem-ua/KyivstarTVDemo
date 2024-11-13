//
//  Promotion+Response.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

extension Promotion {
    struct Response: Decodable {
        let id: Promotion.ID
        let name: String
        let image: URL
        let company: String
        let updatedAt: ISODateCoder
        let releaseDate: ReleaseDateCoder
    }
}

extension Promotion {
    init(_ response: Response) {
        self.init(
            id: response.id,
            name: response.name,
            image: response.image,
            company: response.company,
            updatedAt: response.updatedAt.value,
            releaseDate: response.releaseDate.value
        )
    }
}
