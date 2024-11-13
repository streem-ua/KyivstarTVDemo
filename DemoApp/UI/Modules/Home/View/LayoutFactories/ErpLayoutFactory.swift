//
//  ErpLayoutFactory.swift
//  DemoApp
//
//  Created by Ihor on 03.08.2024.
//

import UIKit

class ErpLayoutFactory: LayoutFactory {
    func createLayout() -> NSCollectionLayoutSection {
        return LayoutHelper.sectionWithHeaderAndCell(CGSize(width: 220, height: 150))
    }
}
