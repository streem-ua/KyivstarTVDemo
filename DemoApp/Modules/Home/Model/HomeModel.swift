//
//  HomeModel.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 21.10.2024.
//

import Foundation

enum Section: Int, CaseIterable {
    case promotions, categories, series, livechannels, epgs

    var title: String {
        switch self {
        case .promotions:
            return ""
        case .categories:
            return "Категорії"
        case .series:
            return "Новинки Київстар ТБ"
        case .livechannels:
            return "Дитячі телеканали"
        case .epgs:
            return "Пізнавальні"
        }
    }

    var isAssetSection: Bool {
        switch self {
        case .series, .livechannels, .epgs:
            return true
        default:
            return false
        }
    }
}

enum Item: Hashable {
    case promotion(Promotion)
    case category(Category)
    case series(Asset)
    case livechannel(Asset)
    case epg(Asset)
}
