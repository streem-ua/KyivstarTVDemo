//
//  AssetsUseCases.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

protocol AssetsUseCases {
    func getPromotionGroup() -> AsyncTask<PromotionGroup>
    func getCategories() -> AsyncTask<CategoryGroup>
    func getContentGroups() -> AsyncTask<[AssetGroup]>
    func getAssetDetails() -> AsyncTask<AssetDetail>
}
