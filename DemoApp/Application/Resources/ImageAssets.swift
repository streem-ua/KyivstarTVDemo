//
//  ImageAssets.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 01.06.2024.
//

import UIKit

enum ImageAssets: String {
    case logo = "logo"
    case lock = "lock"
    case placeholder = "placeholder"
    
    func image() -> UIImage {
        UIImage(named: rawValue) ?? UIImage()
    }
}

