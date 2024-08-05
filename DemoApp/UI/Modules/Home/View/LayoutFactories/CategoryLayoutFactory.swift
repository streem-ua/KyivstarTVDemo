//
//  CategoryLayoutFactory.swift
//  DemoApp
//
//  Created by Ihor on 01.08.2024.
//

import UIKit

final class CategoryLayoutFactory: LayoutFactory {
    func createLayout() -> NSCollectionLayoutSection {
        return LayoutHelper.sectionWithHeaderAndCell(CGSize(width: 110, height: 140))
    }
}
