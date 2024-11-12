//
//  Layer+RoundedShadow.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit

extension CALayer {
    func addRoundedShadow(color: UIColor = .black, opacity: Float = 1, height: CGFloat = 0.5) {
        shadowOpacity = opacity
        shadowRadius = 0
        shadowColor = color.cgColor
        masksToBounds = false
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
        shadowOffset = CGSize(width: 0, height: height)

        if cornerRadius != 0 {
            addShadowWithRoundedCorners()
        }
    }

    func roundCorners(radius: CGFloat) {
        cornerRadius = radius
        if shadowOpacity != 0 {
            addShadowWithRoundedCorners()
        }
    }

    private func addShadowWithRoundedCorners() {
        if let contents = self.contents {
            masksToBounds = false
            sublayers?.filter { $0.frame.equalTo(bounds) }
                      .forEach { $0.roundCorners(radius: cornerRadius) }
            self.contents = nil
            if let sublayer = sublayers?.first,
                sublayer.name == "ShadowContent" {

                sublayer.removeFromSuperlayer()
            }
            let contentLayer = CALayer()
            contentLayer.name = "ShadowContent"
            contentLayer.contents = contents
            contentLayer.frame = bounds
            contentLayer.cornerRadius = cornerRadius
            contentLayer.masksToBounds = true
            insertSublayer(contentLayer, at: 0)
        }
    }
}

