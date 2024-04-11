//
//  Promotions.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

//// MARK: - Promotions
//public struct Promotions: Hashable {
//    public let id, name: String
//    public let promotions: [Promotion]
//}
//
//extension PromotionsAPI {
//    func mapToDoamin() -> Promotions {
//        return Promotions(id: id,
//                                name: name,
//                                promotions: promotions.map { $0.mapToDoamin() })
//    }
//}

// MARK: - Promotion
public struct Promotion: Hashable {
    public let id, name: String
    public let image: String
    public let company, updatedAt, releaseDate: String
}

extension PromotionAPI {
    
    func mapToDoamin() -> Promotion {
        return Promotion(id: id,
                               name: name,
                               image: image,
                               company: company,
                               updatedAt: updatedAt,
                               releaseDate: releaseDate)
    }
}
