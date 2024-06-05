//
//  DetailViewController.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import SwiftUI
import Kingfisher

typealias DetailDestination = ((DetailView.Destination)->())

struct DetailView: View {
    
    //MARK: - Properties
    
    var completionHandler: DetailDestination?
    @StateObject var viewModel = DetailViewModel()
    
    var body: some View {
        VStack {
            headerView
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
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    var headerView: some View {
        ZStack(alignment: .topLeading) {
            KFImage(URL(string: viewModel.model?.image ?? ""))
                .resizable()
                .scaledToFill()
                .frame(height: 211)
                .clipped()
            Button {
                completionHandler?(.back)
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
            }
        }
    }
    
    var title: some View {
        HStack {
            Text(viewModel.model?.description ?? "")
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
            viewModel.playAction()
        } label: {
            HStack {
                Image(systemName: viewModel.playButtonIconName())
                    .padding(.trailing, 10)
                Text(viewModel.playeButtonTitle())
            }
            .modifier(ButtonModifier(bgColor: .blue, borderColor: .blueLight))
            .foregroundColor(.white)
        }
    }
}

#Preview {
    DetailView()
}

//MARK: - Destination

extension DetailView {
    enum Destination {
        case back
    }
}
