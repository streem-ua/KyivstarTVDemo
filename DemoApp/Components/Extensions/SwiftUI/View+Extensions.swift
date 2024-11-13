//
//  View+Extensions.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 29.08.2024.
//

import SwiftUI

extension View {
    func capsuleBorder(color: Color, lineWidth: CGFloat) -> some View {
        overlay(
            Capsule()
                .stroke(color, lineWidth: lineWidth)
        )
    }
    
    func paddingStatusBarTop() -> some View {
        padding(.top, UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? .zero)
    }
}
