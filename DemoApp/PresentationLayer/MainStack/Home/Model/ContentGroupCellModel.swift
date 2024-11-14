//
//  ContentGroupCellModel.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 06.06.2024.
//

import Foundation


struct ContentGroupCellModel: Equatable, Hashable {
    let asset: ContentGroupAsset
    let canBeDeleted: Bool
}
