//
//  SeriesLayoutFactory.swift
//  DemoApp
//
//  Created by Ihor on 02.08.2024.
//

import UIKit

final class MovieLayoutFactory: LayoutFactory {
    func createLayout() -> NSCollectionLayoutSection {
        return LayoutHelper.sectionWithHeaderAndCell(CGSize(width: 110, height: 180))
    }
}
