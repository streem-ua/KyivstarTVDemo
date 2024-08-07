//
//  ModuleFactory.swift
//  DemoApp
//
//  Created by Ihor on 26.07.2024.
//

import UIKit

class ModuleFactory {
    class func homeModule(_ navigationActionCallback: @escaping FlowActionCallback) -> UIViewController {
        let vm = HomeViewModelImp(
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
        vm.onNavigationAction = navigationActionCallback
        return HomeViewController(
            vm
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
