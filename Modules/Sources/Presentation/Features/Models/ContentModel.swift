//
//  ContentModel.swift
//
//
//  Created by Vadim Marchenko on 11.04.2024.
//

import Foundation
import Domain

struct ContentModel {
    let promotions: [Promotion]
    let categories: [Category]
    let movies: [Asset]
    let liveChannels: [Asset]
    let epg: [Asset]
}
