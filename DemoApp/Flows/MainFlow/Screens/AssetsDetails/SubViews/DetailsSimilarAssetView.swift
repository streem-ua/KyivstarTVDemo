//
//  DetailsSimilarAssetView.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

struct DetailsSimilarAssetView: View {
    // MARK: - Properties
    var asset: ContentGroup.Asset
    // MARK: - Main View
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let imageUrl = asset.image, let url = URL(string: imageUrl) {
                AsyncImageView(url: url)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 104, height: 156)
                    .clipped()
                    .cornerRadius(8)
            }
            if let progress = asset.progress {
                DetailsProgressGradientView(progress: CGFloat(progress))
                    .padding([.leading, .bottom], 8)
            }
            if asset.purchased == false {
                Image.res.home.lockedAsset
                    .resizable()
                    .frame(width: 24, height: 24)
                    .padding([.top, .leading], 8)
            }
        }
    }
}
