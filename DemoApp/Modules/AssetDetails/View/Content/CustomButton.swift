//
//  CustomButton.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import SwiftUI

struct CustomButton: View {

    var image: Image? = nil
    
    var title: String? = nil
    
    var backgroundColor: Color = .blue
    
    var borderColor: Color = .clear
    
    var textColor: Color = .white
    
    var cornerRadius: CGFloat = 20
    
    var imageSize: CGSize = CGSize(width: 16, height: 16)
    
    var padding: CGFloat = 16
    
    var horizontalPadding: CGFloat = 24
    
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: padding) {
                if let image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: imageSize.width, height: imageSize.height)
                }

                if let title {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(textColor)
                }
            }
            .padding(.horizontal, horizontalPadding)
            .frame(height: 40)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
    }
}
