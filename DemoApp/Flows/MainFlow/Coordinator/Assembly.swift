//
//  Assembly.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Combine
import UIKit

struct Assembly {
    // MARK: - Methods
    func previewVC(openNext: PassthroughSubject<Void, Never>) -> UIViewController {
        let vc = PreviewVC()
        vc.openNext = openNext
        return vc
    }
    func homeVC(openNext: PassthroughSubject<Void, Never>) -> UIViewController {
        let vm = HomeVM(repository: HomeNetworkRepository())
        let vc = HomeVC(viewModel: vm)
        vm.input.didSelectAsset = openNext
        return vc
    }
    func assetsDetails(backAction: PassthroughSubject<Void, Never>) -> UIViewController {
        let vm = AssetDetailsVM(repository: DetailsNetworkRepository())
        vm.backAction = backAction
        let view = AssetDetailsView(viewModel: vm)
        return view
            .hosted
            .setNavigationBarHidden(true)
    }
}
