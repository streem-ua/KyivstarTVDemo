//
//  DetailMainImageView.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

struct DetailMainImageView: View {
    // MARK: - Properties
    let model: AssetDetails
    let action: (() -> Void)?
    // MARK: - Main View
    var body: some View {
        ZStack(alignment: .topLeading) {
            if let imageUrl = model.image, let url = URL(string: imageUrl) {
                AsyncImageView(url: url, aspectRatio: 375/211)
                    .clipped()
            }
            Button(action: {
                action?()
            }) {
                Image.res.details.backButton
            }
            .frame(width: 40, height: 40)
            .padding(.top, 4)
            .padding(.leading, 24)
        }
    }
}
