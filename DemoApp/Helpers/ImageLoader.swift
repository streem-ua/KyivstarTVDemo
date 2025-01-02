//
//  ImageLoader.swift
//  DemoApp
//
//  Created by Bogdan Akopov on 02.01.2025.
//


import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private let cache = NSCache<NSURL, UIImage>()
    private var tasks: [UIImageView: URLSessionDataTask] = [:]

    private init() {}

    func loadImage(for imageView: UIImageView, from url: URL, placeholder: UIImage? = nil) {
        imageView.image = placeholder

        if let cachedImage = cache.object(forKey: url as NSURL) {
            imageView.image = cachedImage
            return
        }

        cancelLoad(for: imageView)

        let task = URLSession.shared.dataTask(with: url) { [weak self, weak imageView] data, _, error in
            guard let self = self, let imageView = imageView, let data = data, error == nil else { return }
            if let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: url as NSURL)
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }

        tasks[imageView] = task
        task.resume()
    }

    func cancelLoad(for imageView: UIImageView) {
        tasks[imageView]?.cancel()
        tasks[imageView] = nil
    }
}
