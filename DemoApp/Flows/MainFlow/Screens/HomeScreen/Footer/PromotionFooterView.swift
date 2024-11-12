//
//  SectionFooterView.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 21.08.2024.
//

import Combine
import UIKit

final class PromotionFooterView: UICollectionReusableView {    
    // MARK: - UI
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor = UIColor(white: 1.0, alpha: 0.25)
        pageControl.hidesForSinglePage = true
        pageControl.clipsToBounds = true
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    // MARK: - Properties
    private var cancellable = Set<AnyCancellable>()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pageControl)
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.topAnchor.constraint(equalTo: topAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    // MARK: - Configuration
    func configure(with numberOfPages: Int, currentPageSubject: PassthroughSubject<Int, Never>) {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = .zero
        currentPageSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.pageControl.currentPage = $0
            }
            .store(in: &cancellable)
    }
}
