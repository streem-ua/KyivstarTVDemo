//
//  HomePageControlFooterView.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation
import UIKit
import Combine

class HomePageControlFooterView: UICollectionReusableView {
    static let reuseIdentifier = "HomePageControlFooterView"

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.pageIndicatorTintColor = .white.withAlphaComponent(0.3)
        pageControl.currentPageIndicatorTintColor = .white
        return pageControl
    }()
    
    // MARK: - Observable logic
    private var cancellable = Set<AnyCancellable>()

    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 0
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pageControl.topAnchor.constraint(equalTo: self.topAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    // MARK: - Public configuration
    func configure(currentPage: Int,
                   pageCount: Int, 
                   pageProvider: PassthroughSubject<Int, Never>?) {
        pageControl.currentPage = currentPage
        pageControl.numberOfPages = pageCount
        
        pageProvider?
            .assign(to: \.currentPage, on: pageControl)
            .store(in: &cancellable)
    }
    
}
