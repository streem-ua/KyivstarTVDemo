//
//  AssetGroup+Response.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import Foundation

extension AssetGroup {
    struct Response: Decodable {
        let id: AssetGroup.ID
        let name: String
        let type: [String]
        let assets: [Asset.Response]
    }
}

extension AssetGroup {
    init(_ response: Response) {
        self.init(
            id: response.id,
            name: response.name,
            type: response.type.map(ContentType.init).compactMap { $0 },
            assets: response.assets.map(Asset.init)
        )
    }
}
