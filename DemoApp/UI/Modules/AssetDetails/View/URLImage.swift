//
//  URLImage.swift
//  DemoApp
//
//  Created by Ihor on 05.08.2024.
//

import SwiftUI
import Combine

struct URLImage: View {
    @State private var uiImage: UIImage? = nil
    @State private var cancellable: AnyCancellable?
    let url: URL
    
    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { image in
                self.uiImage = image
            }
    }
}
