//
//  UIImage+LoadImage.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 21.08.2024.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(url: String?,
                          placeholder: UIImage? = nil,
                          completion: ((UIImage?) -> Void)? = nil) {
        ImageCache.shared.load(
            url: url,
            startedLoading: { [weak self] in
                self?.image = placeholder
            },
            loadedImage: { [weak self] image in
                completion?(image)
                guard let image else { return }
                self?.image = image
            }
        )
    }
}

final class ImageCache {
    // MARK: - Properties
    static let shared = ImageCache()
    private let imageCache = NSCache<NSURL, UIImage>()
    private let urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadRevalidatingCacheData
        return URLSession(configuration: config)
    }()
    // MARK: - Initializer
    private init() {}
    // MARK: - Interface
    /// Returns the cached image if available, otherwise asynchronously loads and caches it.
    func load(url: String?,
                     startedLoading: (() -> Void)? = nil,
                     loadedImage: @escaping (UIImage?) -> Void) {
        guard let urlText = url,
              let url = URL(string: urlText)
        else {
            DispatchQueue.main.async {
                startedLoading?()
                loadedImage(nil)
            }
            return
        }
        // Check for a cached image
        if let image = imageCache.object(forKey: url as NSURL) {
            DispatchQueue.main.async { loadedImage(image) }
            return
        }
        // Request
        startedLoading?()
        performRequest(url, loadedImage)
    }
    func saveImageToCache(url: String, data: Data) {
        guard let url = URL(string: url),
              let image = UIImage(data: data) else { return }
        imageCache.setObject(image, forKey: url as NSURL, cost: data.count)
    }
    func removeImageFromCache(url: String) {
        guard let url = URL(string: url) else { return }
        imageCache.removeObject(forKey: url as NSURL)
    }
    // MARK: - Private methods
    private func performRequest(_ url: URL, _ completion: @escaping (UIImage?) -> Void) {
        urlSession.dataTask(with: url) { [weak self] data, response, error in
            guard let responseData = data,
                  let image = UIImage(data: responseData)
            else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            // Cache the image
            self?.imageCache.setObject(image, forKey: url as NSURL, cost: responseData.count)
            DispatchQueue.main.async { completion(image) }
        }.resume()
    }
}

