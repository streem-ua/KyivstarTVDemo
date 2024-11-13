//
//  HomeViewController+Collection.swift
//  DemoApp
//
//  Created by Vlad Tkach on 15.08.2024.
//

import Foundation

extension HomeViewController {
    struct Collection {
      
        struct SectionModel: Hashable {
            let section: Section
            let items: [Item]
        }
        
        enum Section: Int, Hashable, CaseIterable {
            case promotions
            case categories
            case movieSeriesGroup
            case liveChannesGroup
            case epgGroup
            
            var title: String? {
                switch self {
                case .categories:
                    return "Категорії" + ":"
                case .movieSeriesGroup:
                    return "Новинки Київстар TV"
                case .liveChannesGroup:
                    return "Дитячі телеканали"
                case .epgGroup:
                    return "Пізнавальні"
                default:
                    return nil
                }
            }
        }

        enum Item: Hashable {
            case promotion(PromotionsResponse.Promotion)
            case category(CategoriesResponse.Category)
            case movieSeries(ContentGroup.Asset)
            case liveChannel(ContentGroup.Asset)
            case epg(ContentGroup.Asset)
        }
        
        enum Status {
            case idl
            case loading
            case loaded([SectionModel])
            case refresh
            case error(Error)
        }
        
    }
}
