//
//  HomeViewAdapter+SectionItem.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import Foundation

extension HomeViewAdapter {
    enum SectionItem: Hashable {
        case promotions(Promotion)
        case categories(Category)
        case movieSeries(ContentGroup.Asset)
        case liveChannels(ContentGroup.Asset)
        case epg(ContentGroup.Asset)
    }
}
