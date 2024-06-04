//
//  DetailViewController.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    
    var body: some View {
        VStack {
            KFImage(URL(string: "https://picsum.photos/id/385/400/600"))
                .resizable()
                .scaledToFill()
                .frame(height: 211)
                .clipped()
            HStack {
                playButton
                Spacer()
                favoriteButton
            }
            .padding()
            Divider()
                .padding(.horizontal)
            title
            Spacer()
        }
    }
    
    var title: some View {
        HStack {
            Text("Title\nTitlesdaddaddadadsdadasdad")
                .font(.custom(Font.bold.rawValue, size: 22))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
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
            .modifier(ButtonModifier(bgColor: .grayLight, borderColor: .white))
            .foregroundColor(Color(asset: .grayDark))
        }
    
    }
    
    var playButton: some View {
        Button {
        } label: {
            HStack {
                Image(systemName: "play.fill")
                    .padding(.trailing, 10)
                Text("Play")
            }
            .modifier(ButtonModifier(bgColor: .blue, borderColor: .blueLight))
            .foregroundColor(.white)
        }
    }
}

#Preview {
    DetailView()
}
