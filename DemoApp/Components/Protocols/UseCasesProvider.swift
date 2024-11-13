//
//  UseCasesProvider.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 26.08.2024.
//

import Foundation

protocol HasAssetsUseCases {
    var assets: AssetsUseCases { get }
}

typealias UseCases = HasAssetsUseCases

protocol UseCasesProvider: UseCases {}
