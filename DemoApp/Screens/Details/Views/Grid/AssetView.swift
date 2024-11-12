//
//  AssetView.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import SwiftUI

struct AssetView: View {
    let asset: SimilarAsset
    @State var progress: CGFloat = 0

    var body: some View {
        ZStack {
            ImageView(urlString: asset.image)
                .background(Color("textSecondary"))
                .cornerRadius(12)
                .clipped()

            ZStack(alignment: .leading) {
                if asset.purchased {
                    Image("lockedAsset")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .position(CGPoint(x: 20, y: 20))
                }

                if asset.progress > 0 {
                    VStack {
                        Spacer()
                        ProgressView(value: Float(asset.progress) * 0.01)
                            .background(Color("progressBlack"))
                    }
                }
            }
            .cornerRadius(12)
            .clipped()
        }
    }
}

#Preview {
    AssetView(asset: SimilarAsset(id: "123", name: "name", image: "https://picsum.photos/id/77/900/500", company: "company", progress: 94, purchased: false, updatedAt: "12334", releaseDate: "135451234"))
}

#Preview {
    let viewModel = DetailViewModel()
    viewModel.asset = load("getAssetDetails.json")
    return ScrollableGridView()
        .environmentObject(viewModel)
}

