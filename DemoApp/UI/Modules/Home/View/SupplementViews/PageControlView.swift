//
//  SupplView.swift
//  DemoApp
//
//  Created by Ihor on 30.07.2024.
//

import UIKit
import Combine

struct PageControlValue {
    let currentPage: Int
}

class PageControlView: UICollectionReusableView {
    static let reuseIdentifier = "PageControlView"
    static let elementKind = "PageControlView"
    private var cancellable = Set<AnyCancellable>()
    private let pageControl = UIPageControl()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPageControl()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 0
    }
    
    private func setupPageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .white.withAlphaComponent(0.3)
        pageControl.currentPageIndicatorTintColor = .white

        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        pageControl.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
    }
    
    func configurePageControl(pageControlValueSubject: PageControlValueSubject, numberOfPages: Int) {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = 0
        
        pageControlValueSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pageControlValue in
                self?.pageControl.currentPage = pageControlValue.currentPage
            }.store(in: &cancellable)
    }
}
