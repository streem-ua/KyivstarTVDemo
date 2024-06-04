//
//  HomeViewController.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 01.06.2024.
//

import UIKit



final class HomeViewController: BaseViewController {
    
    //MARK: - Properties
    var completionHandler: ((HomeViewController.Destination)->())?
    private let viewModel = HomeViewModel()
    private let colltctionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private lazy var provider = HomeCollectionViewProvider(collectionView: colltctionView, viewModel: viewModel)
    
    //MARK: - Init
    
    init(completionHandler: ((HomeViewController.Destination)->())?) {
        super.init(nibName: nil, bundle: nil)
        self.completionHandler = completionHandler
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attachCollectionView()
        provider.updateData()
        configureViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Configure
    
    private func configureViewModel() {
        viewModel.showDetail = {[weak self] in
            self?.completionHandler?(.detail)
            print("sfdsfds")
        }
    }
    
    private func attachCollectionView() {
        addSubview(colltctionView)
        colltctionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension HomeViewController {
    enum Destination {
        case detail
    }
}
