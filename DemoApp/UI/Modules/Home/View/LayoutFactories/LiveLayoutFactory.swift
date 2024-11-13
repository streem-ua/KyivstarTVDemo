//
//  LiveLayoutFactory.swift
//  DemoApp
//
//  Created by Ihor on 03.08.2024.
//

import UIKit

final class LiveLayoutFactory: LayoutFactory {
    func createLayout() -> NSCollectionLayoutSection {
        return LayoutHelper.sectionWithHeaderAndCell(CGSize(width: 110, height: 110))
    }
}
