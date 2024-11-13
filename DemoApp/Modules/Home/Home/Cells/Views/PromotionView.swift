//
//  PromotionView.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import UIKit
import Nuke

final class PromotionView: UIView {
    // MARK: - Constants
    private enum C {
        static let pageControlBottomPadding: CGFloat = 8
        static let pageControlWidth: CGFloat = 130
        static let pageControlHeight: CGFloat = 6
    }
    
    // MARK: - Views
    private lazy var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var pageControl: UIPageControl = {
        var pageControl = UIPageControl()
        pageControl.backgroundStyle = .minimal
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    // MARK: - Private Properties
    private var promotions: [Promotion] = []
    
    // MARK: - Public Properties
    var currentPage: Int = .zero {
        didSet {
            switchToStep(currentPage)
        }
    }
    
    // MARK: - Iniitialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupGestures()
        setupPageControl()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    func configure(promotions: [Promotion]) {
        self.promotions = promotions
        pageControl.numberOfPages = promotions.count
        pageControl.size(forNumberOfPages: 1)
        currentPage = .zero
    }
    
    // MARK: - Setup
    private func setupImageView() {
        addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: .zero),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .zero),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .zero),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .zero)
        ])
    }
    
    private func setupPageControl() {
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor, constant: .zero),
            pageControl.heightAnchor.constraint(equalToConstant: C.pageControlHeight),
            pageControl.widthAnchor.constraint(equalToConstant: C.pageControlWidth),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -C.pageControlBottomPadding)
        ])
    }
    
    private func setupGestures() {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        leftSwipeGesture.direction = .left
        addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        rightSwipeGesture.direction = .right
        addGestureRecognizer(rightSwipeGesture)
    }
    
    // MARK: - Private Methods
    private func switchToStep(_ step: Int) {
        guard !promotions.isEmpty, step < promotions.count && step >= 0 else { return }
        pageControl.currentPage = step
        loadImage(from: promotions[pageControl.currentPage].image)
    }
    
    private func loadImage(from url: URL) {
        ImagePipeline.shared.loadImage(with: url) { [weak self] in
            guard let self, case .success(let response) = $0 else { return }
            self.imageView.image = response.image
        }
    }
    
    // MARK: - Actions
    @objc private func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left: switchToStep(pageControl.currentPage + 1)
        case .right: switchToStep(pageControl.currentPage - 1)
        default: break
        }
    }
}
