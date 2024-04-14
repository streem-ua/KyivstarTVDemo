//
//  RoundedBorderedRectangleModifier.swift
//
//
//  Created by Vadim Marchenko on 14.04.2024.
//

import Foundation
import SwiftUI

struct RoundedBorderedRectangleModifier: ViewModifier {
    var foregroundColor: Color
    var backgroundColor: Color
    var borderColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(foregroundColor)
            .padding(.vertical, 8)
            .background(backgroundColor)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16)
                .strokeBorder(borderColor)
                .offset(y: -1))
    }
}

extension View {
    func roundedBorderedRectangle(foregroundColor: Color,
                                  backgroundColor: Color,
                                  borderColor: Color) -> some View {
        modifier(RoundedBorderedRectangleModifier(foregroundColor: foregroundColor,
                                          backgroundColor: backgroundColor,
                                          borderColor: borderColor))
    }
}
