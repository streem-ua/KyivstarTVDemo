//
//  PromotionGroup+Response.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

extension PromotionGroup {
    struct Response: Decodable {
        let id: PromotionGroup.ID
        let name: String
        let promotions: [Promotion.Response]
    }
}

extension PromotionGroup {
    init(_ response: Response) {
        self.init(
            id: response.id,
            name: response.name,
            promotions: response.promotions.map(Promotion.init)
        )
    }
}
