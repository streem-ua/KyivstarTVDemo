// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import UIKit

// MARK: - Asset Catalogs


enum AssetColor: String {
    case background = "background"
    case biege = "biege"
    case darkBlue = "darkBlue"
    case darkerGray = "darkerGray"
    case lighterGray = "lighterGray"
    case progressBlack = "progressBlack"
    case progressBlue = "progressBlue"
    case text = "text"
    case textBlue = "textBlue"
    case textSecondary = "textSecondary"
    case whiteIndicator = "whiteIndicator"
}

extension UIColor {
    class var background: UIColor { AssetColor(rawValue: "background")!.uiColor }
    class var biege: UIColor { AssetColor(rawValue: "biege")!.uiColor }
    class var darkBlue: UIColor { AssetColor(rawValue: "darkBlue")!.uiColor }
    class var darkerGray: UIColor { AssetColor(rawValue: "darkerGray")!.uiColor }
    class var lighterGray: UIColor { AssetColor(rawValue: "lighterGray")!.uiColor }
    class var progressBlack: UIColor { AssetColor(rawValue: "progressBlack")!.uiColor }
    class var progressBlue: UIColor { AssetColor(rawValue: "progressBlue")!.uiColor }
    class var text: UIColor { AssetColor(rawValue: "text")!.uiColor }
    class var textBlue: UIColor { AssetColor(rawValue: "textBlue")!.uiColor }
    class var textSecondary: UIColor { AssetColor(rawValue: "textSecondary")!.uiColor }
    class var whiteIndicator: UIColor { AssetColor(rawValue: "whiteIndicator")!.uiColor }
}


// MARK: - Implementation Details
extension AssetColor {
    var uiColor: UIColor {
        let bundle = Bundle(for: BundleToken.self)
        return UIColor(named: rawValue, in: bundle, compatibleWith: nil)!
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
