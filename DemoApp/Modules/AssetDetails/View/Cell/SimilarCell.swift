//
//  SimilarCell.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import SwiftUI
import UIKit

struct SimilarCell: View {

    var model: Similar

    var body: some View {
        ZStack {
            ImageView(url: URL(string: model.image))
                .frame(width: 104, height: 156)
                .clipped()

            lockOverlay

            progressBar
        }
        .frame(width: 104, height: 156)
    }

    private var lockOverlay: some View {
        VStack {
            HStack {
                Image("lock_image")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .opacity(model.purchased ? 1 : 0)
                Spacer()
            }
            .padding(.leading, 8)
            .padding(.top, 8)
            Spacer()
        }
        .background(Color.clear)
    }

    private var progressBar: some View {
        VStack {
            Spacer()
            GradientProgressBarView(
                progress: CGFloat(model.progress) / 100,
                firstColor: .colors(.blue),
                secondColor: .colors(.lightBlue),
                progressBarBackground: .colors(.darkGray)
            )
            .opacity(model.progress > 0 ? 1 : 0)
            .frame(height: 4)
        }
    }
}
