//
//  HomeEntitites.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import Foundation

enum Home {
    enum Item: Hashable {
        case promotion(Promotion)
        case category(Category)
        case movie(Asset)
        case liveChannel(Asset)
        case epg(Asset)
        case loading(String)
    }

    enum Section: Int, CaseIterable {
        case promotions
        case categories
        case movies
        case liveChannel
        case epg

        var title: String {
            switch self {
            case .promotions:           return "Promotions"
            case .categories:           return "Категорії"
            case .movies:               return "Новинки Київстар ТБ"
            case .liveChannel:          return "Дитячі телеканали"
            case .epg:                  return "Пізнавальні"
            }
        }
    }
}
