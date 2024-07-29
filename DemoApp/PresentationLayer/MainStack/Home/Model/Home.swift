//
//  HomeSection.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import Foundation

enum Home {
    enum Section: Equatable, Hashable {
        case promotions
        case categories
        case movie(canBeDeleted: Bool)
        case livechannel(canBeDeleted: Bool)
        case epg(canBeDeleted: Bool)
        
        var title: String? {
            switch self {
            case .movie:
                return "Новинки Київстар ТБ"
            case .livechannel:
                return "Дитячи телеканали"
            case .epg:
                return "Пізнавальні"
            case .categories:
                return "Категорії"
            case .promotions:
                return nil
            }
        }
        
        var canBeDeleted: Bool {
            switch self {
            case .movie(let canBeDeleted):
                return canBeDeleted
            case .livechannel(let canBeDeleted):
                return canBeDeleted
            case .epg(let canBeDeleted):
                return canBeDeleted
            default:
                return true
            }
        }
    }
    
    enum Item: Hashable {
        case promotions(Promotion)
        case categories(Category)
        case movie(ContentGroupCellModel)
        case livechannel(ContentGroupCellModel)
        case epg(ContentGroupCellModel)
        
        var itemCanBeDeleted: Bool {
            switch self {
            case .promotions:
                return false
            case .categories:
                return true
            case .movie(let contentGroupCellModel), .livechannel(let contentGroupCellModel), .epg(let contentGroupCellModel):
                return contentGroupCellModel.canBeDeleted
           
            }
        }
    }
}
