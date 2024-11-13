//
//  Asset+Response.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import Foundation

extension Asset {
    struct Response: Decodable {
        let id: Asset.ID
        let name: String
        let image: URL
        let company: String
        let progress: Int
        let purchased: Bool
        let sortIndex: Int
        let updatedAt: ISODateCoder
        let releaseDate: ReleaseDateCoder
    }
}

extension Asset {
    init(_ response: Response) {
        self.init(
            id: response.id,
            name: response.name,
            image: response.image,
            company: response.company,
            progress: response.progress,
            purchased: response.purchased,
            sortIndex: response.sortIndex,
            updatedAt: response.updatedAt.value,
            releaseDate: response.releaseDate.value
        )
    }
}
