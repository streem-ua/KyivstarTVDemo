//
//  AssetDetailView.swift
//  DemoApp
//
//  Created by Nik Dub on 11.07.2024.
//

import SwiftUI
import Kingfisher

struct AssetDetailView: View {
    var body: some View {
        VStack {
            buttonsView
            Divider()
                .padding(.horizontal)
            title
            Spacer()
        }
    }
    
    var buttonsView: some View {
        HStack {
            Spacer()
            favoriteButton
        }
        .padding()
    }
    
    var title: some View {
        HStack {
            Text("")
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding()
    }
    
    var favoriteButton: some View {
        Button {
        } label: {
            HStack {
                Image(systemName: "star.fill")
            }
        }
    }
    
    var errorAlert: Alert {
        Alert(
            title: Text("Error"),
            message: Text(""),
            dismissButton: .default(Text("Ok"))
        )
    }
}

#Preview {
    AssetDetailView()
}
