//
//  CategoryCollectionViewCell.swift
//  DemoApp
//
//  Created by Ihor on 03.08.2024.
//

import UIKit
import Combine

class ImageCollectionViewCell: UICollectionViewCell {
    private var imageLoader: ImageLoader?
    private var cancellable = Set<AnyCancellable>()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        fatalError("Need to be overrided")
    }
    
    func setImage(for url: URL) {
        imageLoader = ImageLoader()
        imageLoader?.load(url)
        imageLoader?.$image
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] image in
                if let image {
                    self?.imageView.image = image
                    self?.imageView.contentMode = .scaleAspectFill
                } else {
                    self?.imageView.image = UIImage(systemName: "photo")
                    self?.imageView.contentMode = .center
                    self?.imageView.backgroundColor = UIColor.black.withAlphaComponent(0.1)
                }
            })
            .store(in: &cancellable)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
