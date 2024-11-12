// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import UIKit.UIImage

typealias AssetImageTypeAlias = UIImage

// MARK: - Asset Catalogs


enum ImageAssets {
    static let kyivstarLogo = ImageAsset(name: "kyivstarLogo")
    static let lock = ImageAsset(name: "lock")
    static let lockedAsset = ImageAsset(name: "lockedAsset")
}

// MARK: - Implementation Details

struct ImageAsset {
    fileprivate(set) var name: String

    var image: AssetImageTypeAlias {
        let bundle = Bundle(for: BundleToken.self)
        let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
        guard let result = image else { fatalError("Unable to load image named \(name).") }
        return result
    }
}

extension AssetImageTypeAlias {
    convenience init!(asset: ImageAsset) {
        let bundle = Bundle(for: BundleToken.self)
        self.init(named: asset.name, in: bundle, compatibleWith: nil)
    }
}

private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
