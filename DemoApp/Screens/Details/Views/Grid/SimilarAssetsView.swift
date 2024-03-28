//
//  SimilarAssetsView.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import SwiftUI

struct SimilarAssetsView: View {
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 104)),
        GridItem(.adaptive(minimum: 104)),
        GridItem(.adaptive(minimum: 104)),
    ]

    let assets: [SimilarAsset]

    var body: some View {
        ScrollView {
            VStack {
                Text("Similar")
                    .font(FontFamily.SFProDisplay.semibold.swiftUIFont(fixedSize: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(assets) { asset in
                        AssetView(asset: asset)
                            .frame(height: 156)
                    }
                }

            }
            .padding(.horizontal, 24)
        }
    }
}

struct MockStore {
    static var assetsResponse: AssetDetails = load("getAssetDetails.json")
    static var assets = assetsResponse.similar
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SimilarAssetsView(assets: MockStore.assets)
    }
}

