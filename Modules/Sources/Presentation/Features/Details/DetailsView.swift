//
//  DetailsView.swift
//
//
//  Created by Vadim Marchenko on 13.04.2024.
//

import SwiftUI
import Domain
import Kingfisher
import Core

struct DetailsView: View {
    
    // MARK: - Properties
    @ObservedObject var viewModel: DetailsViewModel
    @State var showErrorAlert = false
    private let logger = AppLogger.detailsFeature
    private typealias Constant = DetailsConstant
    
    // MARK: - Body
    var body: some View {
        VStack {
            header()
            actionButtons()
                .padding(.top, Constant.ActionButton.top)
                .padding(.bottom, Constant.ActionButton.bottom)
                .padding(.horizontal, Constant.Common.horizontal)
            Divider()
                .padding(.vertical, Constant.Divider.vertical)
                .padding(.horizontal, Constant.Common.horizontal)
            contentView()
                .padding(.horizontal, Constant.Common.horizontal)
        }
        .alert(isPresented: $showErrorAlert) {
            errorAlert()
        }
        .onAppear() {
            Task {
                do {
                    try await viewModel.fetchData()
                } catch let error {
                    logger.error("\(#function) \(error.localizedDescription)")
                    showErrorAlert = true
                }
            }
        }
    }
    
    // MARK: - Header
    @ViewBuilder func header() -> some View {
        KFImage(viewModel.assetDetails?.imageURL)
            .placeholder( {
                ColorAssets.placeholder.suColor
                
            })
            .resizable()
            .aspectRatio(Constant.Header.aspectRatio,
                         contentMode: .fit)
    }
    
    // MARK: - Action buttons
    @ViewBuilder func actionButtons() -> some View {
        HStack {
            // Play
            Button(action: {
                viewModel.isPlaying.toggle()
            }) {
                Label {
                    Text(viewModel.isPlaying ? "Pause" : "Play")
                        .font(.system(size: Constant.ActionButton.fontSize))
                } icon: {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .padding(.trailing, Constant.ActionButton.imagePading)
                }
                .padding(.horizontal,
                         Constant.ActionButton.playButtonHorizontalPadding)
                .roundedBorderedRectangle(foregroundColor: .white,
                                          backgroundColor: ColorAssets.action.suColor,
                                          borderColor: ColorAssets.borderBlue.suColor)
            }
            Spacer()
            
            // Add to favorite
            Button(action: {
                viewModel.isFavourite.toggle()
            }) {
                Image(systemName: viewModel.isFavourite ? "star.fill" : "star")
                    .padding(.horizontal,
                             Constant.ActionButton.addToFavButtonHorizontalPadding)
                    .roundedBorderedRectangle(foregroundColor: ColorAssets.accentGray.suColor,
                                              backgroundColor: ColorAssets.grayLight.suColor,
                                              borderColor: .white)
                
            }
        }
    }
    
    // MARK: - Content view
    @ViewBuilder private func contentView() -> some View {
        ScrollView {
            VStack {
                Text(viewModel.assetDetails?.description ?? "")
                    .font(.system(size: Constant.Content.fontSize,
                                  weight: .bold))
                    .foregroundColor(.black)
                    .font(.title)
            }
        }
    }
    
    // MARK: - Error alert
    private func errorAlert() -> Alert {
        Alert(title: Text("Упс"),
              message: Text("Щось пішло не так"),
              dismissButton: .default(Text("OK")))
    }
}

