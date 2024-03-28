//
//  CustomAsyncImage.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import SwiftUI

struct ImageView: View {
    @ObservedObject private var imageViewModel: ImageViewModel
    @State private var animateGradient = false

    init(urlString: String?) {
        imageViewModel = ImageViewModel(urlString: urlString)
    }

    var body: some View {
        VStack {
            if imageViewModel.image == nil && !imageViewModel.failedToDownload {
                LinearGradient(
                    colors: [.white.opacity(0.5), .gray.opacity(0.2)],
                    startPoint: animateGradient ? .topLeading : .bottomLeading,
                    endPoint: animateGradient ? .bottomTrailing : .topTrailing)
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.linear(duration: 2.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            } else {
                Image(uiImage: imageViewModel.image ?? UIImage())
                    .resizable()
            }
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(urlString: "https://developer.apple.com/news/images/og/swiftui-og.png")
    }
}

