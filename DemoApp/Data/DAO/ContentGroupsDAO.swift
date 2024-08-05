//
//  ContentGroupsDAO.swift
//  DemoApp
//
//  Created by Ihor on 02.08.2024.
//

import Foundation

protocol ContentGroupsDAO {
    func get() -> [ContentGroup]
    func save(_ models: [ContentGroup])
    func delete(_ model: ContentGroup)
    func clearAll()
}

class ContentGroupsDAOImp: ContentGroupsDAO {
    static let shared = ContentGroupsDAOImp()
    
    private var groups: [ContentGroup] = []
    
    func get() -> [ContentGroup] {
        return groups
    }
    
    func save(_ models: [ContentGroup]) {
        groups.removeAll()
        groups.append(contentsOf: models)
    }
    
    func delete(_ model: ContentGroup) {
        groups.removeAll(where: { $0.id == model.id })
    }
    
    func clearAll() {
        groups.removeAll()
    }
}
