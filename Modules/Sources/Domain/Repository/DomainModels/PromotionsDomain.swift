//
//  PromotionsDomain.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

// MARK: - PromotionsDomain
public struct PromotionsDomain: Codable {
    public let id, name: String
    public let promotions: [PromotionDomain]
}

extension PromotionsAPI {
    func mapToDoamin() -> PromotionsDomain {
        return PromotionsDomain(id: id,
                                name: name,
                                promotions: promotions.map { $0.mapToDoamin() })
    }
}

// MARK: - PromotionDomain
public struct PromotionDomain: Codable {
    public let id, name: String
    public let image: String
    public let company, updatedAt, releaseDate: String
}

extension PromotionAPI {
    
    func mapToDoamin() -> PromotionDomain {
        return PromotionDomain(id: id,
                               name: name,
                               image: image,
                               company: company,
                               updatedAt: updatedAt,
                               releaseDate: releaseDate)
    }
}
