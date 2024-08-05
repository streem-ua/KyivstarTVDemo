//
//  PromotionLayoutFactory.swift
//  DemoApp
//
//  Created by Ihor on 01.08.2024.
//

import UIKit
import Combine

final class PromotionLayoutFactory: LayoutFactory {
    private var currentPageSubject: PageControlValueSubject
    
    init(_ currentPageSubject: PageControlValueSubject) {
        self.currentPageSubject = currentPageSubject
    }
    
    func createLayout() -> NSCollectionLayoutSection {
        let promotionHeight = 200.0
//HEADER
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: headerSize,
          elementKind: HeaderCenteredImageView.elementKind,
          alignment: .top,
          absoluteOffset: CGPoint(x: 0, y: 0)
        )
//FOOTER
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let footer = NSCollectionLayoutBoundarySupplementaryItem(
          layoutSize: footerSize,
          elementKind: PageControlView.elementKind,
          alignment: .bottom,
          absoluteOffset: CGPoint(x: 0, y: -50)
        )
        footer.zIndex = 1
        footer.pinToVisibleBounds = true
        footer.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
//ITEM
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
//GROUP
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(promotionHeight)), subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//SECTION
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .paging
        
        section.boundarySupplementaryItems = [header, footer]
        
        section.visibleItemsInvalidationHandler = { (items, offset, env) -> Void in
            guard let itemWidth = items.last?.bounds.width else { return }
            let nextPage = round(offset.x / (itemWidth + section.interGroupSpacing))
            self.currentPageSubject.send(PageControlValue(currentPage: Int(nextPage)))
        }
        return section
    }
}
