//
//  ImageView.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import SwiftUI

struct ImageView: View {
   
    @State private var image: UIImage? = nil
    
    let url: URL?

    var body: some View {
        ZStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            ImageLoader.shared.loadImage(for: url, into: $image)
        }
    }
}
