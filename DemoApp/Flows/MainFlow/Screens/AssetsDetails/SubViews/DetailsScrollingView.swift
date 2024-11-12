//
//  DetailsScrollingView.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

struct DetailsScrollingView: View {
    // MARK: - Properties
    let model: [ContentGroup.Asset]
    // MARK: - Main View
    var body: some View {
        let config = UIConfig()
        LazyVGrid(
            columns: Array(
                repeating:
                    GridItem(
                        .fixed(config.itemWidth),
                        spacing: config.spacing
                    ),
                count: config.numberOfColumns
            ),
            spacing: config.spacing
        ) {
            ForEach(model) { asset in
                ZStack(alignment: .topLeading) {
                    if let imageUrl = asset.image, let url = URL(string: imageUrl) {
                        AsyncImageView(url: url)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: config.itemWidth, height: config.itemHeight)
                            .cornerRadius(8)
                            .overlay(
                                VStack(spacing: 0) {
                                    Spacer()
                                    if let progress = asset.progress {
                                        DetailsProgressGradientView(progress: CGFloat(progress))
                                            .frame(height: 4)
                                    }
                                }
                                .cornerRadius(8)
                                .clipped()
                            )
                    }
                    if asset.purchased == false {
                        Image.res.home.lockedAsset
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding([.top, .leading], 8)
                    }
                }
                .frame(width: config.itemWidth, height: config.itemHeight)
            }
        }
    }
}

fileprivate struct UIConfig {
    // MARK: - Properties
    let numberOfColumns = 3
    let spacing: CGFloat = 8
    let horizontalPadding: CGFloat = 48
    let totalSpacing: CGFloat
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    // MARK: - Init
    init() {
        totalSpacing = spacing * CGFloat(numberOfColumns - 1)
        itemWidth = (UIScreen.main.bounds.width - totalSpacing - horizontalPadding) / CGFloat(numberOfColumns)
        itemHeight = itemWidth * 156 / 104
    }
}
