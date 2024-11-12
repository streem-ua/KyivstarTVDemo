//
//  ScrollableGridView.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import SwiftUI

struct ScrollableGridView: View {
    @EnvironmentObject var viewModel: DetailViewModel

    var body: some View {
        ScrollView {
            VStack {
                VStack(spacing: 4) {
                    let asset = viewModel.asset
                    Text(asset?.name.isEmpty ?? true ? "Unnamed" : asset?.name ?? "")
                        .font(FontFamily.SFProDisplay.bold.swiftUIFont(fixedSize: 22))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    let duration = asset?.duration.formatToHoursAndMinutes() ?? ""
                    let releaseDate = asset?.releaseDate.formatToYear() ?? ""
                    let text = "\(duration) • \(releaseDate)"
                    Text(text)
                        .font(FontFamily.SFProDisplay.regular.swiftUIFont(fixedSize: 14))
                        .foregroundColor(Color("text"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)

                    Text(viewModel.asset?.description ?? "")
                        .font(FontFamily.SFProDisplay.regular.swiftUIFont(fixedSize: 14))
                        .foregroundColor(Color("textSecondary"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 24)
                .padding(.horizontal, 24)

                SimilarAssetsView(assets: viewModel.asset?.similar ?? [])
            }
        }
    }
}

#Preview {
    let viewModel = DetailViewModel()
    viewModel.asset = load("getAssetDetails.json")
    return ScrollableGridView()
        .environmentObject(viewModel)
}

