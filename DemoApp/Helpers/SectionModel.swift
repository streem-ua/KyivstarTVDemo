//
//  SectionModel.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

struct SectionModel<Section, Item>: Hashable where Section: Hashable, Item: Hashable {
    let section: Section
    let items: [Item]
}

