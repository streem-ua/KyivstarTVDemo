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
    @Published var isError = false
    private(set) var networkError: NetworkError?
    
    //MARK: - Init
    
    /// HomeModel is not currently used; it is provided to illustrate how data will be passed to the DetailView.
    init(model: DetailModel) {}
    
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
    
    func networkErrorDescription() -> String {
        networkError?.localizedDescription ?? ""
    }
    
    //MARK: - Private
    
    @MainActor private func loadData() {
        Task {
            do {
                model = try await networkService.assetDetails()
            } catch {
                networkError = error as? NetworkError
                isError = true
            }
        }
    }
}
