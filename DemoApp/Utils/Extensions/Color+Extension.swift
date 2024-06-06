//
//  Color+Extension.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import SwiftUI

extension Color {
    init(asset: ColorAssets) {
        self.init(asset.rawValue)
    }
}
