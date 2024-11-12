//
//  DetailPlayButton.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

struct DetailPlayButton: View {
    // MARK: - Properties
    let action: (() -> Void)?
    // MARK: - Init
    init(action: (() -> Void)? = nil) {
        self.action = action
    }
    // MARK: - Main View
    var body: some View {
        Button(action: {
            action?()
        }) {
            HStack(spacing: 8) {
                Image(systemName: "play.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
                Text("Play")
                    .font(.system(size: 16, weight: .medium))
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 8)
            .foregroundColor(.white)
            .background(Color(hex: "#0063C6"))
            .cornerRadius(32)
            .overlay(
                RoundedRectangle(cornerRadius: 32)
                    .stroke(Color(hex: "#229FFF"), lineWidth: 1)
            )
            .shadow(color: Color(hex: "#0063C6").opacity(0.5), radius: 1, x: 0, y: 1)
        }
        .frame(width: 129, height: 40)
    }
}
