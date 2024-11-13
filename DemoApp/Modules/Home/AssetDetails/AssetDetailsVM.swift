//
//  AssetDetailsVM.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 30.08.2024.
//

import Foundation

protocol AssetDetailsVMDelegate: AnyObject {
    func assetDetailsVMDidBack(_ viewModel: AssetDetailsVM)
}

final class AssetDetailsVM: BaseVM {
    // MARK: - Public Properties
    @Published var assetDetail: AssetDetail?
    
    // MARK: - Private Properties
    private weak var delegate: AssetDetailsVMDelegate?
    
    // MARK: - Initializa
    init(assetDetail: AssetDetail, delegate: AssetDetailsVMDelegate) {
        self.assetDetail = assetDetail
        self.delegate = delegate
    }
    
    // MARK: - Actions
    func didTapBack() {
        delegate?.assetDetailsVMDidBack(self)
    }
}
