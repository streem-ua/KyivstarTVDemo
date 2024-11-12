//
//  FavoriteButton.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSelected: Bool

    var body: some View {
        Button {
            isSelected.toggle()
        } label: {
            Label("Toggle Favorite", systemImage: "star.fill")
                .labelStyle(.iconOnly)
                .foregroundColor(isSelected ? .yellow : Color("darkBlue"))
        }
        .frame(width: 66, height: 40)
        .background(Color("biege"))
        .cornerRadius(32)
        .shadow(color: Color("biege").opacity(0.5), radius: 0.1, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("whiteIndicator"), lineWidth: 1)
        )
    }
}


#Preview {
    FavoriteButton(isSelected: .constant(true))
}

