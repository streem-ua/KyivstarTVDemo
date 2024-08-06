import UIKit
import Combine

typealias PageControlValueSubject = PassthroughSubject<PageControlValue, Never>

final class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModelImp
    var currentPageValueSubject = PageControlValueSubject()
    private var errorController: UIAlertController?
    
    var snapshot = NSDiffableDataSourceSnapshot<Home.Section, Home.Item>()
    private var cancellable = Set<AnyCancellable>()
    
    var dataSource: UICollectionViewDiffableDataSource<Home.Section, Home.Item>!
    
    init(_ viewModel: HomeViewModelImp) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero , collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(viewModel, action: #selector(viewModel.onRefreshAction), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
        configureCompositionalLayout()
        configureDataSource()
        bind()
        
        viewModel.onViewDidLoad()
    }
    
    func bind() {
        viewModel.buildUIPassthroughSubject
            .receive(on: DispatchQueue.main)
            .sink {[weak self] sectionViewModels in
                self?.applyDataSource(sectionViewModels)
            }
            .store(in: &cancellable)
        
        viewModel.deleteSectionPassthroughSubject
            .receive(on: DispatchQueue.main)
            .sink {[weak self] sectionViewModel in
                self?.deleteSectionAndApplyDataSource(sectionViewModel)
            }
            .store(in: &cancellable)
        
        viewModel.$showLoadingView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isLoading in
                if isLoading {
                    self?.showLoadingView()
                } else {
                    self?.hideLoadingView()
                }
            }
            .store(in: &cancellable)
        
        viewModel.$showRefreshing
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isRefreshing in
            if isRefreshing {
                self?.refreshControl.beginRefreshing()
            } else {
                self?.refreshControl.endRefreshing()
            }
        }
        .store(in: &cancellable)
        
        viewModel.$errorText
            .receive(on: DispatchQueue.main)
            .sink {[weak self] error in
            if let error = error {
                self?.showError(error)
            } else {
                self?.hideError()
            }
        }
        .store(in: &cancellable)
    }
    
    //    MARK: - Update UI
    private func applyDataSource(_ sectionViewModels: [Home.SectionViewModel]) {
        var snapshot = self.snapshot
        sectionViewModels.forEach { vm in
            snapshot.appendSections([vm.section])
            snapshot.appendItems(vm.items, toSection: vm.section)
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    private func deleteSectionAndApplyDataSource(_ sectionViewModel: Home.SectionViewModel) {
        var snapshot = self.dataSource.snapshot()
        snapshot.deleteSections([sectionViewModel.section])
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    //    MARK: - Data source
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Home.Section, Home.Item>(collectionView: collectionView, cellProvider: {(collectionView, indexPath, model) -> UICollectionViewCell? in
            
            switch model {
            case .promotion(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCell.reuseIdentifier, for: indexPath) as! PromotionCell
                cell.configure(with: model)
                return cell
            case .category(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
                cell.configure(with: model)
                return cell
            case .movie(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
                cell.configure(with: model)
                return cell
            case .live(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveCell.reuseIdentifier, for: indexPath) as! LiveCell
                cell.configure(with: model)
                return cell
            case .epg(let model):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ErpCell.reuseIdentifier, for: indexPath) as! ErpCell
                cell.configure(with: model)
                return cell
            }
        })
        
        dataSource.supplementaryViewProvider = {[weak self] (collectionView, kind, indexPath) in
            guard let self = self else { return UICollectionReusableView() }
            
            let section = self.viewModel.sectionViewModels.compactMap({ $0.section })[indexPath.section]
            
            switch (section, kind) {
            case (Home.Section.promotions, HeaderCenteredImageView.elementKind):
                let headerView = self.collectionView.dequeueReusableSupplementaryView(
                    ofKind: HeaderCenteredImageView.elementKind,
                    withReuseIdentifier: HeaderCenteredImageView.reuseIdentifier,
                    for: indexPath) as! HeaderCenteredImageView
                headerView.imageView.image = UIImage(resource: .logo)
                return headerView
                
            case (Home.Section.promotions, PageControlView.elementKind):
                let headerView = self.collectionView.dequeueReusableSupplementaryView(
                    ofKind: PageControlView.elementKind,
                    withReuseIdentifier: PageControlView.reuseIdentifier,
                    for: indexPath) as! PageControlView
                
                headerView.configurePageControl(
                    pageControlValueSubject: self.currentPageValueSubject,
                    numberOfPages: self.viewModel.numberOfPromotions()
                )
                return headerView
                
            case (_, SectionHeaderView.elementKind):
                
                let headerView = self.collectionView.dequeueReusableSupplementaryView(
                    ofKind: SectionHeaderView.elementKind,
                    withReuseIdentifier: SectionHeaderView.reuseIdentifier,
                    for: indexPath) as! SectionHeaderView
                
                let section = self.viewModel.sectionViewModels[indexPath.section]
                headerView.configure(section, canBeDeleted: true) { sectionViewModel in
                    self.viewModel.onDeleteSection(sectionViewModel)
                }
                return headerView
                
            default:
                return UICollectionReusableView()
            }
        }
    }
    
    //    MARK: Configure UI
    private func setupUI() {
        collectionView.register(PromotionCell.self, forCellWithReuseIdentifier: PromotionCell.reuseIdentifier)
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        collectionView.register(LiveCell.self, forCellWithReuseIdentifier: LiveCell.reuseIdentifier)
        collectionView.register(ErpCell.self, forCellWithReuseIdentifier: ErpCell.reuseIdentifier)
        
        collectionView.register(
            PageControlView.self,
            forSupplementaryViewOfKind: PageControlView.elementKind,
            withReuseIdentifier: PageControlView.reuseIdentifier
        )
        
        collectionView.register(
            HeaderCenteredImageView.self,
            forSupplementaryViewOfKind: HeaderCenteredImageView.elementKind,
            withReuseIdentifier: HeaderCenteredImageView.reuseIdentifier
        )
        collectionView.register(
            SectionHeaderView.self,
            forSupplementaryViewOfKind: SectionHeaderView.elementKind,
            withReuseIdentifier: SectionHeaderView.reuseIdentifier
        )
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.refreshControl = self.refreshControl
        
        view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    func configureCompositionalLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) in
            let section = self.viewModel.sectionViewModels.map({ $0.section })[sectionNumber]
            
            let layout = self.getLayoutFactory(by: section).createLayout()
            return layout
        }
        collectionView.setCollectionViewLayout(layout, animated: true )
    }
    
    private func getLayoutFactory(by section: Home.Section) -> LayoutFactory {
        switch section {
        case .promotions:
            return PromotionLayoutFactory(currentPageValueSubject)
        case .categories:
            return CategoryLayoutFactory()
        case .movieGroup(_):
            return MovieLayoutFactory()
        case .liveGroup(_):
            return LiveLayoutFactory()
        case .epgGroup(_):
            return ErpLayoutFactory()
        }
    }
    

    //    MARK: UI Actions
    private func showError(_ errorString: String) {
        errorController = UIAlertController(title: "Error happened",
                                      message: errorString,
                                      preferredStyle: .alert)
        
        errorController!.addAction(UIAlertAction(title: "Ok", style: .destructive))
        present(errorController!, animated: true)
    }
    
    private func hideError() {
        errorController?.dismiss(animated: true)
    }
    
    private func showLoadingView() {
        collectionView.isHidden = true
        activityIndicator.startAnimating()
    }
    
    private func hideLoadingView() {
        collectionView.isHidden = false
        activityIndicator.stopAnimating()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = viewModel.sectionViewModels[indexPath.section]
        let item = section.items[indexPath.row]
        viewModel.onItemSelected(item)
    }
}
