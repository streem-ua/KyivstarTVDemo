//
//  FavoriteButton.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import SwiftUI

struct FavoriteButton: View {
    // MARK: - Constants
    private enum C {
        static let imageHeight: CGFloat = 16
        static let imageWidth: CGFloat = 18
        static let height: CGFloat = 40
        static let padding: CGFloat = 24
    }
    
    // MARK: - Public Properties
    var image: ImageResource
    var action: () -> Void
    
    // MARK: - Views
    private var imageView: some View {
        Image(image)
            .resizable()
            .frame(width: C.imageWidth, height: C.imageHeight)
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            HStack {
                imageView
            }
            .padding(.horizontal, C.padding)
            .frame(height: C.height)
            .background(Color(.systemGray5), alignment: .center)
            .clipShape(.capsule)
            .capsuleBorder(color: .white, lineWidth: .one)
            .shadow(color: Color(.systemGray5), radius: .zero, y: .one)
        }
    }
}

#Preview {
    FavoriteButton(image: .icStar) {}
}
