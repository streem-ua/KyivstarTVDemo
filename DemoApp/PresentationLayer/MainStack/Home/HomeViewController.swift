//
//  HomeViewController.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 01.06.2024.
//

import UIKit
import Combine

typealias HomeDestination = (HomeViewModel.Destination) -> ()

final class HomeViewController: BaseViewController {
    
    //MARK: - Properties
    
    var completionHandler: HomeDestination?
    
    private let viewModel = HomeViewModel()
    private let colltctionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private lazy var provider = HomeCollectionViewProvider(collectionView: colltctionView, viewModel: viewModel)
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: - Init
    
    init(completionHandler: HomeDestination?) {
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
        provider.reloadCollectionView()
        configureViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: Configure
    
    private func configureViewModel() {
        viewModel.$destination
            .receive(on: DispatchQueue.main)
            .sink { [weak self] destination in
            guard let destination else {return}
            self?.completionHandler?(destination)
        }.store(in: &cancellables)
        
        viewModel.$networkError
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
            guard let error else { return }
            self?.showNetworkErrorAlert(title: "Oops", message: error.localizedDescription)
        }.store(in: &cancellables)
    }
    
    private func attachCollectionView() {
        addSubview(colltctionView)
        colltctionView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}
