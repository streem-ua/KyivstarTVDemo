//
//  HomeVC.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Combine
import UIKit

final class HomeVC<T: PHomeVM>: UIViewController, Controller {
    typealias ViewModelType = T
    // MARK: - UI
    private var collectionView: UICollectionView!
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refreshControl
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    // MARK: - Properties
    let viewModel: ViewModelType
    var cancellables = Set<AnyCancellable>()
    private var adapter: HomeViewAdapter!
    // MARK: - Init
    init(viewModel: T) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder: \(coder) has not been implemented")
    }
    // MARK: - Overriden methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        setupAdapter()
        setupActivityIndicator()
        bindOutputs(with: viewModel)
        viewModel.input.viewDidLoad.send()
    }
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.refreshControl = refreshControl
        view.addSubview(collectionView)
    }
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    private func setupAdapter() {
        adapter = HomeViewAdapter(collectionView: collectionView)
        adapter.didSelectItem
            .sink { [weak self] in
                self?.handleSelection()
            }
            .store(in: &adapter.cancellable)
        adapter.didDeleteSection
            .sink { [weak self] in
                self?.viewModel.input.didDeleteSection.send($0)
            }
            .store(in: &adapter.cancellable)
    }
    func bindOutputs(with viewModel: ViewModelType) {
        viewModel.output.sectionData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.adapter.updateSection($0)
            }
            .store(in: &cancellables)
        viewModel.output.onDeleteSection
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.adapter.deleteSection($0)
            }
            .store(in: &cancellables)
        viewModel.output.viewStateOutput
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.handleViewState($0)
            }
            .store(in: &cancellables)
    }
    private func handleViewState(_ state: HomeVM.ViewState) {
        switch state {
        case .showLoading(let show):
            showHideCollectionView(show)
            show ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
            refreshControl.endRefreshing()
        case .showAlert:
            AlertManager.showAlert(
                from: self,
                title: "Error",
                message: "Something went wrong"
            )
        }
    }
    private func handleSelection() {
        viewModel.input.didSelectAsset.send()
    }
    private func showHideCollectionView(_ state: Bool) {
        collectionView.isHidden = state
    }
    @objc private func handleRefresh() {
        refreshControl.beginRefreshing()
        viewModel.input.didBeginRefreshing.send()
    }
}
