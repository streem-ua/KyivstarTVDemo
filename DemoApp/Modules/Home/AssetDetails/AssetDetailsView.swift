//
//  AssetDetailsView.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import SwiftUI
import NukeUI

struct AssetDetailsView: View {
    private enum C {
        static let titleFont: Font = .system(size: 22, weight: .bold)
        static let playTitle = "Play"
        static let padding24: CGFloat = 24
        static let padding16: CGFloat = 16
        static let padding12: CGFloat = 12
        static let padding9: CGFloat = 9
        static let padding4: CGFloat = 4
        static let imageHeight: CGFloat = 211
        static let opacity30: CGFloat = 0.3
        static let backButtonSpace: CGFloat = 40
        static let backImageHeight: CGFloat = 16
        static let backImageWidth: CGFloat = 16
    }
    
    // MARK: - Public Properties
    var image: URL?
    var title: String
    var backAction: () -> Void
    
    // MARK: - Views
    private var gradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                .black.opacity(C.opacity30),
                .black.opacity(.zero),
                .black.opacity(C.opacity30)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    private var titleView: some View {
        Text(title)
            .foregroundColor(.black)
            .font(C.titleFont)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, C.padding24)
    }
    
    private var playButton: some View {
        MediaButton(title: C.playTitle, image: .icPlay) {
            // Supposed to launch the movie
        }
    }
    
    private var favoriteButton: some View {
        FavoriteButton(image: .icStar) {
            // Supposed to add to favorite
        }
    }
    
    private var dividerView: some View {
        Divider()
            .padding(.horizontal, C.padding24)
            .padding(.bottom, C.padding16)
    }
    
    private var buttonsStackView: some View {
        HStack {
            playButton
            Spacer()
            favoriteButton
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, C.padding12)
        .padding(.bottom, C.padding16)
        .padding(.horizontal, C.padding24)
    }
    
    private var backButtoView: some View {
        Button(action: backAction) {
            Image(.icArrow)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: C.backImageWidth, height: C.backImageHeight)
        }
        .frame(width: C.backButtonSpace, height: C.backButtonSpace)
        .padding(.leading, C.padding9)
        .padding(.top, C.padding4)
    }
    
    private var imageView: some View {
        AsyncImageView(image: image)
            .overlay(gradient)
            .frame(height: C.imageHeight)
            .clipped()
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack(spacing: .zero) {
                imageView
                buttonsStackView
                dividerView
                titleView
            }
            .navigationBarItems(leading: backButtoView)
            .frame(maxHeight: .infinity, alignment: .top)
            .paddingStatusBarTop()
            .ignoresSafeArea(.container, edges: .top)
        }
    }
}

#Preview {
    AssetDetailsView(
        image: URL(string: "https://picsum.photos/id/574/400/600"),
        title: "Title"
    ) {}
}
