//
//  HomeSectionLayoutParameters.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit

typealias HomeSectionLayout = SectionLayoutParameters & HomeLayoutParameters

protocol HomeLayoutParameters {
    var showSectionHeader: Bool { get }
    var showLock: Bool { get }
}

struct HomeSectionLayoutParameters: HomeSectionLayout {
    let itemSize: NSCollectionLayoutSize
    let groupSize: NSCollectionLayoutSize
    let columnCount: Int
    let scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    let showSectionHeader: Bool
    let showLock: Bool

    init(itemSize: NSCollectionLayoutSize,
         groupSize: NSCollectionLayoutSize,
         columnCount: Int,
         scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous,
         showSectionHeader: Bool = true,
         showLock: Bool = false) {
        self.itemSize = itemSize
        self.groupSize = groupSize
        self.columnCount = columnCount
        self.scrollBehavior = scrollBehavior
        self.showSectionHeader = showSectionHeader
        self.showLock = showLock
    }
}

