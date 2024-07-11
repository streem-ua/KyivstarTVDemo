//
//  Section.swift
//  DemoApp
//
//  Created by Nik Dub on 10.07.2024.
//

import UIKit

class Section: Hashable {
    var id: UUID
    var type: SectionType
    var name: String?
    var cellItems: [CellItem] = []
    
    init(name: String?, type: SectionType, cellItems: [CellItem]) {
        self.id = UUID()
        self.name = name
        self.type = type
        self.cellItems = cellItems
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}
