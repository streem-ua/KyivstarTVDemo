//
//  PlayButton.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import SwiftUI

struct PlayButton: View {
    var body: some View {
        Button {
            print("did tap Play button")
        } label: {
            Label("Play", systemImage: "play.fill")
                .foregroundColor(.white)
                .font(.subheadline)
                .padding(.horizontal, 30)
        }
        .frame(height: 35)
        .background(Color("textBlue"))
        .cornerRadius(32)
        .shadow(color: Color("textBlue"), radius: 0.1, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("progressBlue"), lineWidth: 1)
        )
    }
}

#Preview {
    PlayButton()
}
