//
//  DetailIconButton.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

struct DetailIconButton: View {
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
            Image(systemName: "star.fill")
                .font(.system(size: 22))
                .foregroundColor(Color(hex: "#1E1E1E"))
                .frame(width: 66, height: 40)
                .background(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color(hex: "#FEFEFE"), lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 32)
                                .fill(Color(hex: "#E9E7E7"))
                        )
                        .shadow(color: Color(hex: "#E9E7E7"), radius: 0, x: 0, y: 1)
                )
        }
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
    }
}
