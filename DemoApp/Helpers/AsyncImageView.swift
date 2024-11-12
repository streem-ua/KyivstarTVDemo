//
//  AsyncImageView.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

struct AsyncImageView: View {
    // MARK: - Properties
    @StateObject private var loader: ImageLoader
    private let placeholder: Image
    private let aspectRatio: CGFloat?
    // MARK: - Init
    //TODO: - Need to create UIConfig to init with it
    init(url: URL, placeholder: Image = .res.home.placeHolder, aspectRatio: CGFloat? = nil) {
        self._loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
        self.aspectRatio = aspectRatio
    }
    // MARK: - Main View
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    // MARK: - Private methods
    private var content: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(aspectRatio, contentMode: .fit)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(aspectRatio, contentMode: .fit)
            }
        }
    }
}
