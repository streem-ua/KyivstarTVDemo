//
//  PImageFromRes.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit.UIImage
import SwiftUI

protocol PImageFromRes {
    associatedtype T
    static func image(_ name: String) -> T
}
extension UIImage: PImageFromRes {
    static func image(_ name: String) -> UIImage {
        UIImage(named: name, in: .`self`, compatibleWith: nil)!
    }
}
extension SwiftUI.Image: PImageFromRes {
    static func image(_ name: String) -> Image {
        Image(name, bundle: .`self`)
    }
}
