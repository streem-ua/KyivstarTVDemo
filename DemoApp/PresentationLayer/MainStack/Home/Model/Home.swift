//
//  HomeSection.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import Foundation

enum Home {
    enum Section: Int {
        case promotions
        case categories
        case movie
        case livechannel
        case epg
        
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
    }
    
    enum Item: Hashable {
        case promotions(Promotion)
        case categories(Category)
        case movie(ContentGroupAsset)
        case livechannel(ContentGroupAsset)
        case epg(ContentGroupAsset)
    }
}
