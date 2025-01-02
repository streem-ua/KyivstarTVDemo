//
//  Section.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//



import Foundation

enum Section: Int, Hashable {
    case promotions
    case categories
    case movieSeries
    case liveChannel
    case epg

    var headerTitle: String? {
        switch self {
        case .promotions:
            return nil
        case .categories:
            return "Категорії:"
        case .movieSeries:
            return "Новинки Київстар ТБ"
        case .liveChannel:
            return "Дитячі телеканали"
        case .epg:
            return "Пізнавальні"
        }
    }
}

enum ItemType: Hashable {
    case promotion(Promotion)
    case category(Category)
    case movieSeries(Asset)
    case liveChannel(Asset)
    case epg(Asset)
}