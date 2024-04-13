//
//  Category.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

// MARK: - Category
public struct Category: Hashable {
    public let id, name: String
    public let image: String
}

extension CategoryAPI {
    func mapToDoamin() -> Category {
        return Category(id: id,
                              name: name,
                              image: image)
    }
}
