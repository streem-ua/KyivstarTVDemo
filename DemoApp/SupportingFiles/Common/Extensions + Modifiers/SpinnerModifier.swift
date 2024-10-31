//
//  SpinnerModifier.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import SwiftUI

struct SpinnerModifier: ViewModifier {
    @Binding var isShowing: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isShowing)
                .blur(radius: isShowing ? 3 : 0)

            if isShowing {
                ZStack {
                    Rectangle()
                        .fill(.gray.opacity(0.4))
                        .ignoresSafeArea()

                    ProgressView()
                        .padding()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.blue))
                        .scaleEffect(4)
                }
            }
        }
    }
}
