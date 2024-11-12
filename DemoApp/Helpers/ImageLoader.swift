//
//  ImageLoader.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    // MARK: - Properties
    @Published var image: UIImage?
    private let url: URL
    // MARK: - Init
    init(url: URL) {
        self.url = url
    }
    // MARK: - Interface
    func load() {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }.resume()
    }
}
