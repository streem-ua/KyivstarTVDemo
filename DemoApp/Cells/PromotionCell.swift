//
//  PromotionCell.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//

import UIKit

class PromotionCell: UICollectionViewCell {
    static let identifier = "PromotionCell"

    private var overlayView = UIView()
    private var pageControl = UIPageControl()
    private var promotions: [Promotion] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PromotionImageCell")
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupOverlay()
        setupPageControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        promotions = []
        pageControl.currentPage = 0
        collectionView.reloadData()
    }

    private func setupCollectionView() {
        contentView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalToConstant: 328),
            collectionView.heightAnchor.constraint(equalToConstant: 180),
            collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    private func setupOverlay() {
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(overlayView)
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            overlayView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        overlayView.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
        ])
    }

    private func updatePageControlAppearance() {
        pageControl.numberOfPages = promotions.count
        pageControl.currentPage = 0
    }
    
    func configure(with promotions: [Promotion]) {
        self.promotions = promotions
        collectionView.reloadData()
        updatePageControlAppearance()
    }
}

extension PromotionCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return promotions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionImageCell", for: indexPath)
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .systemGray5

        if let url = URL(string: promotions[indexPath.item].image) {
            imageView.setImage(from: url)
        } else {
            imageView.image = UIImage(named: "defaultImage")
        }

        imageView.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 328),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor)
        ])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 328, height: 180)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5)
        pageControl.currentPage = page
    }
}
