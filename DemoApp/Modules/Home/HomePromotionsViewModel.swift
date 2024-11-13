//
//  HomePromotionsViewModel.swift
//  DemoApp
//
//  Created by Vlad Tkach on 16.08.2024.
//

import Foundation
import Combine

final class HomePromotionsViewModel {
    typealias SectionItem = HomeViewController.Collection.Item

    var currentPageSubject = PassthroughSubject<Int, Never>()
    private var cancellable = Set<AnyCancellable>()

    var currentPage = 0
    var pageCount: Int {
        promotions.count
    }
    
    private var promotions: [SectionItem] = []
    
    // MARK: - Init
    init() {
        internalBinding()
    }
    
    private func internalBinding() {
        currentPageSubject.sink { [weak self] value in
            self?.currentPage = value
        }.store(in: &cancellable)
    }
    
    // MARK: - Public
    func updatePromotions(_ promotions: [SectionItem]) {
        self.currentPage = 0
        self.promotions = promotions
    }
}
