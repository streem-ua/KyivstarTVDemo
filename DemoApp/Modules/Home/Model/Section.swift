//
//  Section.swift
//  DemoApp
//
//  Created by Nik Dub on 10.07.2024.
//

import UIKit
// 1
class Section: Hashable {
    var id = UUID()
    // 2
    var title: String
    var imageURLs: [String]
    var isVisible = true
    
    init(title: String, imageURLs: [String]) {
        self.title = title
        self.imageURLs = imageURLs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}
