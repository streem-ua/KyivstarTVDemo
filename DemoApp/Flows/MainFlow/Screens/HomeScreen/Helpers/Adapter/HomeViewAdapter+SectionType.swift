//
//  HomeViewAdapter+SectionType.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import Foundation

extension HomeViewAdapter {
    enum SectionType: Int, CaseIterable {
        case promotions
        case categories
        case movieSeries
        case liveChannels
        case epg
        
        var title: String? {
            switch self {
            case .categories:
                return "Категорії" + ":"
            case .movieSeries:
                return "Новинки Київстар TV"
            case .liveChannels:
                return "Дитячі телеканали"
            case .epg:
                return "Пізнавальні"
            default:
                return nil
            }
        }
    }
}
