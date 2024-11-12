//
//  PLayoutFactory.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit

protocol PLayoutFactory {
    func buildSectionLayout() -> NSCollectionLayoutSection
}
