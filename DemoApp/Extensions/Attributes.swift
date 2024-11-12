//
//  Attributes.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 22.08.2024.
//

import UIKit

extension String {
    enum Attribute {
        case kern(CGFloat?)
        case font(UIFont?)
        case color(UIColor?)
        case lineHeightMultiple(CGFloat?)
    }
}

extension String {
    func toAttributed(_ attributes: [Attribute]) -> NSAttributedString {
        let dict = attributes.toDefaultDict
        return NSAttributedString(string: self, attributes: dict)
    }
    func toAttributed(_ attributes: Attribute...) -> NSAttributedString {
        toAttributed(attributes.map { $0 })
    }
}

// MARK: - [Attribute] -
extension Array where Element == String.Attribute {
    var toDefaultDict: [NSAttributedString.Key: Any] {
        let paragraphStyle = NSMutableParagraphStyle()
        var newAttributes = reduce(into: [NSAttributedString.Key: Any]()) { partialResult, attribute in
            switch attribute {
            case .kern(let kernValue):
                if let kernValue { partialResult[.kern] = kernValue }
            case .font(let font):
                if let font { partialResult[.font] = font }
            case .color(let color):
                if let color { partialResult[.foregroundColor] = color }
            case .lineHeightMultiple(let height):
                if let height { paragraphStyle.lineHeightMultiple = height }
            }
        }
        newAttributes[.paragraphStyle] = paragraphStyle
        return newAttributes
    }
}
