//
//  CollectionView+Reusable.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit

extension UICollectionView {
    func reusableCell<T>(type: T.Type, indexPath: IndexPath) -> T where T: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T else {
            fatalError("CollectionViewCell's type is not valid")
        }
        return cell
    }
    func reusableHeaderFooterView<T>(
        type: T.Type,
        indexPath: IndexPath,
        ofKind kind: String
    ) -> T where T: UICollectionReusableView {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier,
                                                          for: indexPath) as? T else {
            fatalError("UICollectionReusableView's type is not valid")
        }
        return view
    }
    func reusableSupplementaryView<T: UICollectionReusableView>(
        ofKind kind: String,
        type: T.Type,
        indexPath: IndexPath
    ) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("UICollectionReusableView of type \(T.self) could not be dequeued")
        }
        return view
    }
}
