//
//  UIModels.swift
//  DemoApp
//
//  Created by Ihor on 05.08.2024.
//

import Foundation

struct AssetDetailsModels {
    enum UIState {
        case loading
        case success(AssetDetails)
        case failure(AssetDetailsModels.AssetDetailsError)
    }
    
    enum AssetDetailsError: Error {
        case somethingWrong
    }
}

extension AssetDetailsModels.AssetDetailsError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .somethingWrong:
            return "Something went wrong"
        }
    }
}
