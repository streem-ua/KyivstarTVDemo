//
//  DetailsProgressGradientView.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

struct DetailsProgressGradientView: View {
    // MARK: - Properties
    var progress: CGFloat
    // MARK: - Main View
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "#0063C6"), Color(hex: "#229FFF")]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: geometry.size.width * (progress / 100))
        }
    }
}
