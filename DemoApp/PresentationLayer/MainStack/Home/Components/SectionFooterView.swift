//
//  SectionFooterView.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 04.06.2024.
//

import UIKit
import Combine

final class SectionFooterView: UICollectionReusableView {
    
    //MARK: - Properties
    
    private var pagingInfoToken: AnyCancellable?
    
    static let identifier = "SectionFooterView"
    private let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 10
        return view
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        attachPageControll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subscribeTo(subject: PassthroughSubject<PagingInfo, Never>, for section: Int) {
        pagingInfoToken = subject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pagingInfo in
                self?.pageControl.currentPage = pagingInfo.currentPage
            }
    }
    
    //MARK: - Configure
    
    func configure(with numberOfPages: Int) {
        if pageControl.currentPage != numberOfPages {
            pageControl.numberOfPages = numberOfPages
        }
    }
    
    private func configure() {
        isUserInteractionEnabled = false
    }
    
    private func attachPageControll() {
        addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.top.bottom.centerX.equalToSuperview()
            $0.width.equalTo(150)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        pagingInfoToken?.cancel()
        pagingInfoToken = nil
    }
}
