//
//  AssetDetailsView.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI
import Combine

struct AssetDetailsView<VM: PAssetDetailsVM>: View {
    // MARK: - Properties
    @ObservedObject var viewModel: VM
    // MARK: - Main View
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let model = viewModel.assetDetail {
                VStack(alignment: .leading, spacing: .zero) {
                    // Main Image
                    DetailMainImageView(model: model) {
                        viewModel.backAction.send()
                    }
                    // Buttons
                    HStack {
                        DetailPlayButton()
                        Spacer()
                        DetailIconButton()
                    }
                    .padding(.horizontal)
                    .padding(.top, 12)
                    Divider()
                        .background(Color(hex: "#E9E7E7"))
                        .padding(.init(top: 16, leading: 24, bottom: 16, trailing: 24))
                }
                .fixedSize(horizontal: false, vertical: true)
                
                if let similarAssets = model.similar, !similarAssets.isEmpty {
                    // If there is data for the Similar section, use ScrollView
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 8) {
                            DetailsFullDescriptionView(model: model)
                            // Section "Similar"
                            Text("Similar")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.init(hex: "1E2228"))
                                .padding(.top, 16)
                                .padding(.horizontal, 24)
                            DetailsScrollingView(model: similarAssets)
                        }
                    }
                } else {
                        DetailsFullDescriptionView(model: model, showOnlyTitle: true)
                        Spacer()
                }
            } else {
                ProgressView {
                    Text("Loading....")
                }
            }
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text("Failed to load asset details."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            viewModel.viewDidLoad.send()
        }
        .background(Color.white)
    }
}
