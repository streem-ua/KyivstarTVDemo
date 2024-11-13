//
//  AssetDetails.swift
//  DemoApp
//
//  Created by Ihor on 05.08.2024.
//

import SwiftUI
import Combine

struct AssetDetailsView: View {
    @StateObject var viewModel: AssetDetailsViewModel
    
    var body: some View {
        ScrollView {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .success(let assetDetails):
                contentView(assetDetails)
            case .failure(let error):
                Text(error.debugDescription)
            }
        }.onAppear(perform: {
            viewModel.onViewDidiLoad()
        })
    }
    
    func contentView(_ assetDetails: AssetDetails) -> some View {
        VStack {
            URLImage(url: URL(string: assetDetails.image)!)
            
            HStack {
                Button(action: {
                    // Action
                }) {
                    HStack {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                        Text("Play")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                }
                
                Spacer()
                
                Button(action: {
                    // Action
                }) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.gray)
                        .padding()
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(8)
                }
            }
            .padding()
            
            Divider()
                .padding([.leading, .trailing])
            
            Text(assetDetails.description)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding([.leading, .bottom, .trailing])
            
            Spacer()
        }
    }
}

#Preview {
    AssetDetailsView(
        viewModel: AssetDetailsViewModel(
            assetUseCase:
                ContentGroupsUseCaseImp(
                    ContentGroupsClientImp(),
                    ContentGroupsDAOImp()
                )
        )
    )
}
