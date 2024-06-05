//
//  DetailModel.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 05.06.2024.
//

import Foundation

struct DetailModel {
    var image = ""
    
    mutating func updateData(model: AssetDetails) {
        image = model.image
    }
}
