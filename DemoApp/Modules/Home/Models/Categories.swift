//
//  Categories.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation

struct CategoriesResponse: Decodable, Hashable {
    
    struct Category: Decodable, Hashable {
        let id: String
        let name: String
        let image: String
    }
    
    let categories: [Category]
}
