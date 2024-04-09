//
//  CategoryDomain.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import Data

// MARK: - CategoriesDomain
public struct CategoriesDomain {
    let categories: [CategoryDomain]
}

extension CategoriesAPI {
    func mapToDoamin() -> CategoriesDomain {
        return CategoriesDomain(categories: categories.map { $0.mapToDoamin() })
    }
}

// MARK: - CategoryDomain
public struct CategoryDomain {
    let id, name: String
    let image: String
}

extension CategoryAPI {
    func mapToDoamin() -> CategoryDomain {
        return CategoryDomain(id: id,
                              name: name,
                              image: image)
    }
}
