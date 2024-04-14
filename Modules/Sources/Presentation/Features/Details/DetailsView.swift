//
//  DetailsView.swift
//
//
//  Created by Vadim Marchenko on 13.04.2024.
//

import SwiftUI
import Domain
import Kingfisher

struct DetailsView: View {
    
    @ObservedObject var viewModel: DetailsViewModel
    
    var body: some View {
        VStack {
            header()
            actionButtons()
                .padding(.top, 12)
                .padding(.bottom, 16)
            Divider()
                .padding(.horizontal, 24)
                .padding(.vertical, 8)
        }
        Spacer()
    }
    
    @ViewBuilder func header() -> some View {
        Color.blue
            .aspectRatio(375/211, contentMode: .fit)
    }
    
    @ViewBuilder func actionButtons() -> some View {
        HStack {
            // MARK: - Play
            Button(action: {
                
            }) {
                Label {
                    Text("Play")
                        .font(.subheadline)
                } icon: {
                    Image(systemName: "play.fill")
                        .padding(.trailing, 4)
                }
                .foregroundColor(.white)
                .padding(.horizontal, 32)
                .padding(.vertical, 8)
                .background(ColorAssets.action.suColor
                        .clipShape(.capsule))
            }
            
            Spacer()
            
            // MARK: - Add to fav
            Button(action: {
                
            }) {
                
                Image(systemName: "star")
                    .foregroundColor(.white)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 8)
                    .background(ColorAssets.hint.suColor
                        .clipShape(.capsule))
            }
        }
        .padding(.horizontal, 24)
    }
}

