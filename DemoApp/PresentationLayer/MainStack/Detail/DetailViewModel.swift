//
//  DetailViewModel.swift
//  DemoApp
//
//  Created by Karpenko Bohdan on 05.06.2024.
//

import Foundation

final class DetailViewModel: ObservableObject {
    //MARK: - Properties
    
    private let networkService = NetworkService()
    @Published private(set) var model: AssetDetails?
    @Published private(set) var isPlay = false
    @Published private(set) var isFavorite = false
    
    //MARK: - Init
    
    init() {}
    
    //MARK: - OpenFunc
    
    func playAction() {
        isPlay.toggle()
    }
    
    @MainActor func onAppear() {
        loadData()
    }
    
    func playeButtonTitle() -> String {
        isPlay ? "Pause" : "Play"
    }
    
    func playButtonIconName() -> String {
        isPlay ? "pause.fill" : "play.fill"
    }
    
    func favoriteAction() {
        isFavorite.toggle()
    }
    
    //MARK: - Private
    
    @MainActor private func loadData() {
        Task {
            model = try await networkService.assetDetails()
        }
    }
}
