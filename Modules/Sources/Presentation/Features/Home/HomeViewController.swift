//
//  HomeViewController.swift
//
//
//  Created by Vadim Marchenko on 09.04.2024.
//

import Foundation
import UIKit

fileprivate typealias DataSource = UICollectionViewDiffableDataSource<Home.Section, Home.Item>
fileprivate typealias Snapshot = NSDiffableDataSourceSnapshot<Home.Section, Home.Item>

final class HomeViewController: UIViewController, Viewable {
    
    // MARK: - Properties
    let viewModel: HomeViewModel
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = ColorAssets.action
        return activityIndicatorView
    }()
    
    private var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    private lazy var dataSource = makeDataSource()
    
    //    private var layout: UICollectionViewLayout = {
    //        var layour = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
    //
    //        }
    //    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        viewModel.$dataSource
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] dataSource in
                var snapshot = Snapshot()
                for sectionModel in dataSource {
                    snapshot.appendSections([sectionModel.section])
                    snapshot.appendItems(sectionModel.items, toSection: sectionModel.section)
                }

                self?.dataSource.apply(snapshot)
            }
            .store(in: &viewModel.cancellables)

        
        fetchData()
        setupConstraints()
    }
    
    // MARK: - Private methods
    private func fetchData() {
        activityIndicatorView.startAnimating()
        Task {
            do {
                try await viewModel.fetchData()
            } catch let error {
                viewModel.logger.error("\(error.localizedDescription)")
                showErrorAlert()
            }
            activityIndicatorView.stopAnimating()
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "error-alert-title".localized,
                                      message: "error-alert-text".localized,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "error-alert-action".localized,
                                      style: .default,
                                      handler: { [weak self] _ in
            self?.fetchData()
        }))
        alert.addAction(UIAlertAction(title: "error-alert-close".localized, style: .destructive))
        present(alert, animated: true)
    }
    
    private func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .category(let categories):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionCell.className, for: indexPath) as! CategoryCollectionCell
                return cell
            case .epg(let epg):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpgCollectionCell.className, for: indexPath) as! EpgCollectionCell
                return cell
            case .liveChannel(let liveChannel):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveChannelCollectionCell.className, for: indexPath) as! LiveChannelCollectionCell
                return cell
            case .promotion(let promotion):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionCell.className, for: indexPath) as! PromotionCollectionCell
                return cell
            case .movie(let movie):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.className, for: indexPath) as! MovieCollectionCell
                return cell
            }
        }
        return dataSource
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        setupActivityIndicatorConstraints()
    }
    
    private func setupActivityIndicatorConstraints() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}

