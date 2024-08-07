//
//  Asset.swift
//  DemoApp
//
//  Created by Ihor on 27.07.2024.
//

import Foundation

struct Asset : Codable, Hashable {
    let id : String
    let name : String
    let image : String
    let progress : Int
    let purchased : Bool
    let sortIndex : Int
}

