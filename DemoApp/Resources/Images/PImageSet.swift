//
//  PImageSet.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit.UIImage
import SwiftUI

protocol PImageSet {
    associatedtype ImageRes: PImageFromRes
}
extension PImageSet {
    static var res: ImageResources<ImageRes> { .init() }
}

extension UIImage: PImageSet {
    typealias ImageRes = UIImage
}
extension Image: PImageSet {
    typealias ImageRes = Image
}
