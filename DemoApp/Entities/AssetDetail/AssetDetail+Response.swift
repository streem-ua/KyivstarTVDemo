//
//  AssetDetail+Response.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 30.08.2024.
//

import Foundation

extension AssetDetail {
    struct Response: Decodable {
        let id: AssetDetail.ID
        let name: String
        let image: URL
        let company: String
    }
}

extension AssetDetail {
    init(_ response: Response) {
        self.init(
            id: response.id,
            name: response.name,
            image: response.image,
            company: response.company
        )
    }
}
