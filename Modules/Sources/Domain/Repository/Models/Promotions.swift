//
//  Promotions.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

public struct Promotion: Hashable {
    public let id, name: String
    public let imageURL: URL?
    public let company, updatedAt, releaseDate: String
}

extension PromotionAPI {
    
    func mapToDoamin() -> Promotion {
        let imageURL = URL(string: image)
        return Promotion(id: id,
                               name: name,
                               imageURL: imageURL,
                               company: company,
                               updatedAt: updatedAt,
                               releaseDate: releaseDate)
    }
}
