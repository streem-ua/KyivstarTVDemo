//
//  HomeMovieCollectionCell.swift
//
//
//  Created by Vadim Marchenko on 11.04.2024.
//

import Foundation
import UIKit
import Core
import Domain

final class HomeMovieCollectionCell: HomeContentBaseCollectionCell {
    
    override func setupConstraints() {
        super.setupConstraints()
        
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 156/104).isActive = true
    }
}
