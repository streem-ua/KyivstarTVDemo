//
//  SectionData.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import Foundation

struct SectionData {
    // MARK: - Properties
    let section: HomeViewAdapter.SectionType
    let items: [HomeViewAdapter.SectionItem]
    let canBeDeleted: Bool
    // MARK: - Init
    init(
        section: HomeViewAdapter.SectionType,
        items: [HomeViewAdapter.SectionItem],
        canBeDeleted: Bool = true
    ) {
        self.section = section
        self.items = items
        self.canBeDeleted = canBeDeleted
    }
}
