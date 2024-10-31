//
//  ImageLoader.swift
//  DemoApp
//
//  Created by Alex Oliynyk on 23.10.2024.
//

import UIKit
import SDWebImage
import Combine
import SwiftUI

@MainActor
class ImageLoader {

    static let shared = ImageLoader()

    private init() {}

    private var cancellables = Set<AnyCancellable>()
    private let placeholderImage = UIImage(named: "empty_image")

    func loadImage(into imageView: UIImageView, from url: URL?, showLoader: Bool = true, cachePolicy: SDWebImageOptions = .refreshCached) {
        guard let url = url else {
            imageView.image = placeholderImage
            return
        }

        Task {
            let activityIndicator = createActivityIndicator()
            if showLoader {
                setupActivityIndicator(activityIndicator, in: imageView)
                activityIndicator.startAnimating()
            }

            do {
                let image = try await loadImage(from: url, cachePolicy: cachePolicy)
                imageView.image = image
            } catch {
                imageView.image = placeholderImage
            }

            if showLoader {
                removeActivityIndicator(from: imageView)
            }
        }
    }

    func loadImage(for url: URL?, into image: Binding<UIImage?>, cachePolicy: SDWebImageOptions = .refreshCached) {
        guard let url = url else {
            Task { @MainActor in
                image.wrappedValue = placeholderImage
            }
            return
        }

        Task {
            do {
                let downloadedImage = try await loadImage(from: url, cachePolicy: cachePolicy)
                Task { @MainActor in
                    image.wrappedValue = downloadedImage
                }
            } catch {
                Task { @MainActor in
                    image.wrappedValue = placeholderImage
                }
            }
        }
    }

    private func loadImage(from url: URL, cachePolicy: SDWebImageOptions) async throws -> UIImage? {
        return try await withCheckedThrowingContinuation { continuation in
            var isResumed = false
            SDWebImageManager.shared.loadImage(with: url, options: cachePolicy, progress: nil) { image, _, error, _, _, _ in
                guard !isResumed else { return }
                isResumed = true

                if let error = error {
                    continuation.resume(throwing: error)
                } else if let image = image {
                    continuation.resume(returning: image)
                } else {
                    continuation.resume(throwing: NSError(domain: "ImageLoader", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unexpected error: No image or error returned"]))
                }
            }
        }
    }

    private func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }

    private func setupActivityIndicator(_ activityIndicator: UIActivityIndicatorView, in imageView: UIImageView) {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }

    private func removeActivityIndicator(from imageView: UIImageView) {
        imageView.subviews.filter { $0 is UIActivityIndicatorView }.forEach { $0.removeFromSuperview() }
    }
}
