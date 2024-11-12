//
//  SectionLayoutParameters.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit

protocol SectionLayoutParameters {
    var itemSize: NSCollectionLayoutSize { get }
    var groupSize: NSCollectionLayoutSize { get }
    var columnCount: Int { get }
    var scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior { get }
}
