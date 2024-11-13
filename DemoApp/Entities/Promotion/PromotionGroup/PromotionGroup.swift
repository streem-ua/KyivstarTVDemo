//
//  PromotionGroup.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

struct PromotionGroup: Equatable, Hashable, Identifiable {
    let id: String
    let name: String
    let promotions: [Promotion]
}
