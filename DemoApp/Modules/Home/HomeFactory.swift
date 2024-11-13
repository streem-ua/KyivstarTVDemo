//
//  HomeFactory.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 28.08.2024.
//

import UIKit

protocol HomeFactoryProtocol: AnyObject {
    func makeHomeVC(delegate: HomeVMDelegate) -> HomeVC
    func makeAssetDetails(assetDetail: AssetDetail, delegate: AssetDetailsVMDelegate) -> AssetDetailsVC
}

final class HomeFactory: ModuleFactory, HomeFactoryProtocol {
    func makeHomeVC(delegate: HomeVMDelegate) -> HomeVC {
        makeController {
            $0.viewModel = HomeVM(useCases: useCases, delegate: delegate)
        }
    }
    
    func makeAssetDetails(assetDetail: AssetDetail, delegate: AssetDetailsVMDelegate) -> AssetDetailsVC {
        makeController {
            $0.viewModel = AssetDetailsVM(assetDetail: assetDetail, delegate: delegate)
        }
    }
}
