//
//  ControlButton.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import SwiftUI

struct MediaButton: View {
    // MARK: - Constants
    private enum C {
        static let imageSide: CGFloat = 16
        static let spacing: CGFloat = 16
        static let height: CGFloat = 40
        static let font: Font = .system(size: 16, weight: .semibold)
        static let paddingHorizontal: CGFloat = 32
    }
    
    // MARK: - Public Properties
    var title: String
    var image: ImageResource
    var action: () -> Void
    
    // MARK: - Views
    private var imageView: some View {
        Image(image)
            .resizable()
            .frame(width: C.imageSide, height: C.imageSide)
    }
    
    private var titleView: some View {
        Text(title)
            .font(C.font)
            .foregroundColor(.white)
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: action) {
            HStack(spacing: C.spacing) {
                imageView
                titleView
            }
            .padding(.horizontal, C.paddingHorizontal)
            .frame(height: C.height)
            .background(Color(.navy), alignment: .center)
            .clipShape(.capsule)
            .capsuleBorder(color: Color(.azure), lineWidth: .one)
            .shadow(color: Color(.navy), radius: .zero, y: .one)
        }
    }
}

#Preview {
    MediaButton(title: "Play", image: .icPlay) {}
}
