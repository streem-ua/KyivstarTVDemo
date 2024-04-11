//
//  SectionModel.swift
//  
//
//  Created by Vadim Marchenko on 11.04.2024.
//

import Foundation

struct SectionModel<Section, Item>: Hashable where Section: Hashable, Item: Hashable {
    let section: Section
    let items: [Item]
}

