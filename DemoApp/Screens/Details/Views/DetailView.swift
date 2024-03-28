//
//  DetailView.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var viewModel: DetailViewModel

    var body: some View {
        if viewModel.asset == nil {
            ProgressView()
               .progressViewStyle(.circular)
               .scaleEffect(2.0, anchor: .center)
        } else {
            DetailContentView()
        }
    }
}

struct DetailContentView: View {
    @EnvironmentObject var viewModel: DetailViewModel
    @State private var isFavorite = false

    var body: some View {
        VStack(spacing: 0) {
            ImageView(urlString: viewModel.asset?.image)
                .frame(height: 211)
            HStack {
                PlayButton()
                Spacer()
                FavoriteButton(isSelected: $isFavorite)
            }
            .padding(EdgeInsets(top: 12, leading: 24, bottom: 16, trailing: 12))

            Divider()
                .frame(height: 1)
            ScrollableGridView()
        }
    }
}

#Preview {
    let viewModel = DetailViewModel()
    viewModel.asset = load("getAssetDetails.json")
    return DetailView()
        .environmentObject(viewModel)
}

