//
//  PAssetDetailsVM.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 23.08.2024.
//

import Combine

protocol PAssetDetailsVM: ObservableObject {
    // Input
    var viewDidLoad: PassthroughSubject<Void, Never> { get }
    var backAction: PassthroughSubject<Void, Never> { get }
    // Output
    var showError: Bool { get set }
    var assetDetail: AssetDetails? { get }
}
