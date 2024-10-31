//
//  GradientProgressBar.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import UIKit

class GradientProgressBar: UIView {

    var firstColor: UIColor = .blue {
        didSet {
            updateGradientColors()
        }
    }

    var secondColor: UIColor = .red {
        didSet {
            updateGradientColors()
        }
    }

    var progressBarBackground: UIColor = .white {
        didSet {
            self.backgroundColor = progressBarBackground
        }
    }

    var progress: CGFloat = 0 {
        didSet {
            updateProgressLayerFrame()
        }
    }

    private let progressLayer = CALayer()
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateProgressLayerFrame()
        gradientLayer.frame = progressLayer.bounds
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = progressBarBackground

        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        progressLayer.addSublayer(gradientLayer)

        layer.addSublayer(progressLayer)

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 4)
        ])
    }

    private func updateGradientColors() {
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
    }

    private func updateProgressLayerFrame() {
        let progressRect = CGRect(x: 0, y: 0, width: bounds.width * progress, height: bounds.height)
        progressLayer.frame = progressRect
        gradientLayer.frame = progressLayer.bounds
    }
}
