//
//  HomeCellProgressView.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 02.06.2024.
//

import UIKit

final class ProgressView: UIView {
    
    //MARK: - Properties
    
    private let gradientLayer = CAGradientLayer()
    
    var progress: CGFloat = 0.0 {
        didSet {
            isHidden = progress == 0
            updateProgress()
        }
    }
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setupProgress()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        setupProgress()
    }
    
    //MARK: - Configure
    
    private func configure() {
        backgroundColor = .color(.grayDark)
    }
    
    private func configureProgressFrame() {
        gradientLayer.frame.origin = .zero
        gradientLayer.frame.size = CGSize(width: width*progress, height: height)
    }
    
    private func setupProgress() {
        let gradientColors = [UIColor.color(.blue).cgColor, UIColor.color(.blueLight).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = gradientColors
        updateProgress()
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureProgressFrame()
    }
    
    private func updateProgress() {
        gradientLayer.frame.size.width = width * progress
    }
}
