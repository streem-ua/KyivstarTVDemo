//
//  GroupCell.swift
//  DemoApp
//
//  Created by Ihor on 03.08.2024.
//

import UIKit

class AssetBaseCell: ImageCollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.appFont(ofSize: 12)
        label.textColor = .appBlack()
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.appFont(ofSize: 11)
        label.textColor = .appGray()
        return label
    }()
    
    let lockImageView: UIImageView = {
        let lockView = UIImageView(image: UIImage(resource: .lockIcon))
        lockView.translatesAutoresizingMaskIntoConstraints = false
        lockView.contentMode = .scaleAspectFit
        return lockView
    }()
    
    let progressView: UIProgressView = {
        let view = UIProgressView(progressViewStyle: .bar)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.trackTintColor = UIColor.appBlack()
        view.progressTintColor = UIColor.appBlue()
        return view
    }()
}

