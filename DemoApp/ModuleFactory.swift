//
//  ModuleFactory.swift
//  DemoApp
//
//  Created by Ihor on 26.07.2024.
//

import UIKit

class ModuleFactory {
    static func homeModule() -> UIViewController {
        return HomeViewController(
            HomeViewModelImp(
                PromotionsUseCaseImp(
                    PromotionsClientImp()
                ),
                CategoryUseCaseImp(
                    CategoryClientImp()
                ),
                ContentGroupsUseCaseImp(
                    ContentGroupsClientImp(),
                    ContentGroupsDAOImp.shared
                )
            )
        )
    }
    
    static func assetDetailsModule() -> UIViewController{
        let view = AssetDetailsView(
            viewModel: AssetDetailsViewModel(
                assetUseCase: ContentGroupsUseCaseImp(
                    ContentGroupsClientImp(),
                    ContentGroupsDAOImp.shared
                )
            )
        )
        return AssetDetailsViewController(detailView: view)
    }
}
