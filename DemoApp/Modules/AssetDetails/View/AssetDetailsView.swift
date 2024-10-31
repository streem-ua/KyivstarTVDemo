//
//  AssetDetailsView.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import SwiftUI

struct AssetDetailsView: View {
   
    @ObservedObject var coordinatorWrapper: AssetDetailCoordinatorWrapper

    @StateObject private var viewModel = AssetDetailsViewModel()

    private let gridItems = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)

    var body: some View {
        VStack(spacing: 0) {
            headerView
            actionButtons
            separatorView
            contentView
            Spacer()
        }
        .background(Color(.colors(.background)))
        .onAppear(perform: viewModel.getAssetDetails)
        .spinner(isShowing: $viewModel.isShowSpinner)
    }

    @ViewBuilder
    private var headerView: some View {
        ZStack(alignment: .topLeading) {
            AssetImageView(urlString: viewModel.assetDetails?.image)
                .frame(height: 200)

            backButton
                .padding(.leading, 40)
                .padding(.top)
        }
        .padding(.top, 32)
    }

    private var backButton: some View {
        Button(action: { coordinatorWrapper.coordinator?.didFinishAssetDetail() }) {
            Image("back_image")
                .resizable()
                .frame(width: 10, height: 16)
        }
    }

    private var actionButtons: some View {
        HStack {
            CustomButton(image: Image("play_image"), 
                         title: "Play",
                         backgroundColor: Color(.colors(.blue)),
                         borderColor: Color(.colors(.lightBlue)),
                         horizontalPadding: 32,
                         action: { })
            Spacer()
            CustomButton(image: Image("star_image"),
                         backgroundColor: Color(.colors(.lightGray)),
                         borderColor: Color.white,
                         horizontalPadding: 24,
                         action: { })
        }
        .padding(.horizontal, 24)
        .padding(.top, 48)
    }

    private var separatorView: some View {
        Rectangle()
            .fill(Color(.colors(.lightGray)))
            .frame(height: 1)
            .padding(.horizontal, 24)
            .padding(.top, 16)
    }

    private var contentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 8) {
                assetNameView
                detailsView
                descriptionView
                similarLabelView
                similarItemsView
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        }
    }

    private var assetNameView: some View {
        Text({
            if let name = viewModel.assetDetails?.name,
               !name.isEmpty {
                return name
            } else {
                return "Empty Name"
            }
        }())
        .foregroundColor(Color(.colors(.black)))
        .font(.system(size: 22, weight: .bold))
        .lineSpacing(8)
    }

    private var detailsView: some View {
        Text(viewModel.getDetails())
            .foregroundColor(Color(.colors(.blueBlack)))
            .font(.system(size: 14, weight: .semibold))
    }

    private var descriptionView: some View {
        Text(viewModel.assetDetails?.description ?? "")
            .foregroundColor(Color(.colors(.gray)))
            .font(.system(size: 12))
    }

    private var similarLabelView: some View {
        Text("Similar")
            .foregroundColor(Color(.colors(.black)))
            .font(.system(size: 16, weight: .semibold))
    }

    private var similarItemsView: some View {
        LazyVGrid(columns: gridItems, spacing: 16) {
            ForEach(viewModel.assetDetails?.similar ?? []) { item in
                SimilarCell(model: item)
                    .cornerRadius(12)
            }
        }
        .background(Color.clear)
        .padding(.top, 16)
    }
}

struct AssetImageView: View {
    let urlString: String?

    var body: some View {
        if let urlString = urlString, let imageUrl = URL(string: urlString) {
            ImageView(url: imageUrl)
        } else {
            Image("empty_image")
                .resizable()
        }
    }
}
