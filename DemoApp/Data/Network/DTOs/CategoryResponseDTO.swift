//
//  CategoryResponseDTO.swift
//  DemoApp
//
//  Created by Ihor on 27.07.2024.
//

import Foundation

struct CategoryResponseDTO: Decodable {
    let categories: [CategoryDTO]
}

extension CategoryResponseDTO {
    struct CategoryDTO: Decodable {
        let id: String
        let name: String
        let image: String
    }
}
