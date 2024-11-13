//
//  UICollectionView+Helpers.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import UIKit

extension UICollectionView {
    func registerNib<T>(for cellClass: T.Type) where T: UICollectionViewCell {
        let identifier = String(describing: cellClass)
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func dequeueReusableCollectionViewCell<T: UICollectionViewCell>(cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: cellClass), for: indexPath) as? T else {
            fatalError("Cannot find cell \(String(describing: cellClass))")
        }
        return cell
    }
    
    func dequeueReusableHeader<Header: UICollectionReusableView>(_ headerClass: Header.Type, for indexPath: IndexPath) -> Header {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: headerClass), for: indexPath
        ) as? Header else {
            fatalError("Cannot find view \(String(describing: headerClass))")
        }
        return view
    }
    
    func makeCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath, builder: (T) -> Void) -> T {
        with(dequeueReusableCollectionViewCell(cellClass: cellClass, for: indexPath)) {
            builder($0)
        }
    }
    
    func register(_ types: UICollectionViewCell.Type...) {
        types.forEach(registerNib)
    }
    
    func registerHeader<Header: UICollectionReusableView>(_ type: Header.Type) {
        register(
            type,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: String(describing: type)
        )
    }
    
    func makeHeader<Header: UICollectionReusableView>(
        _ type: Header.Type,
        for indexPath: IndexPath,
        builder: (Header) -> Void
    ) -> Header {
        with(dequeueReusableHeader(type, for: indexPath)) {
            builder($0)
        }
    }
}
