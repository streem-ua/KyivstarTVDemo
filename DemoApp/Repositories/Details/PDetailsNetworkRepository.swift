//
//  PDetailsNetworkRepository.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Foundation

protocol PDetailsNetworkRepository: AnyObject {
    func getAssetsDetails() async -> NetResult<AssetDetails?>
}
