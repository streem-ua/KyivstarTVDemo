//
//  GradientProgressBarView.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 24.10.2024.
//

import SwiftUI

struct GradientProgressBarView: UIViewRepresentable {
    
    var progress: CGFloat
    
    var firstColor: UIColor
    
    var secondColor: UIColor
    
    var progressBarBackground: UIColor

    func makeUIView(context: Context) -> GradientProgressBar {
        let progressBar = GradientProgressBar()
        progressBar.firstColor = firstColor
        progressBar.secondColor = secondColor
        progressBar.progressBarBackground = progressBarBackground
        return progressBar
    }

    func updateUIView(_ uiView: GradientProgressBar, context: Context) {
        uiView.progress = progress
    }
}
