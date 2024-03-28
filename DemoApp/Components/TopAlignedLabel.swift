//
//  TopAlignedLabel.swift
//  DemoApp
//
//  Created by Denys Zaiakin on 28.03.2024.
//

import UIKit

class TopAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        guard let text = text as NSString? else {
            super.drawText(in: rect)
            return
        }

        let textSize = text.boundingRect(with: rect.size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font as Any], context: nil).size
        var newRect = rect
        newRect.origin.y = rect.origin.y
        newRect.size.height = min(textSize.height, rect.size.height)

        super.drawText(in: newRect)
    }
}

