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
    public let imageURL: URL?
}

extension CategoryAPI {
    func mapToDoamin() -> Category {
        let imageURL = URL(string: image)
        return Category(id: id,
                              name: name,
                              imageURL: imageURL)
    }
}
