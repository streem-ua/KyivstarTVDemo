//
//  HomeSection.swift
//
//
//  Created by Vadim Marchenko on 10.04.2024.
//

import Foundation
import Domain

// MARK: - HomeSection
enum Home {
    
    enum Section: CaseIterable {
        case promotion
        case category
        case movie
        case liveChannel
        case epg
    }
    
    enum Item: Hashable {
        case promotion(Promotion)
        case category(Category)
        case movie(Asset)
        case liveChannel(Asset)
        case epg(Asset)
    }
}
