//
//  UIModels.swift
//  DemoApp
//
//  Created by Ihor on 02.08.2024.
//
import Foundation

struct Home {
    enum Item: Hashable {
        case promotion(Promotion)
        case category(Category)
        case movie(Asset)
        case live(Asset)
        case epg(Asset)
    }
    
    enum Section: CaseIterable, Hashable {
        static var allCases: [Home.Section] {
            return [.promotions, .categories, .movieGroup(nil), .liveGroup(nil), .epgGroup(nil)]
        }
        
        case promotions
        case categories
        case movieGroup(ContentGroup?)
        case liveGroup(ContentGroup?)
        case epgGroup(ContentGroup?)
        
        var title: String? {
            switch self {
            case .categories:
                return "Категорії:"
            case .movieGroup(let group):
                return group?.name
            case .liveGroup(let group):
                return group?.name
            case .epgGroup(let group):
                return group?.name
            default:
                return nil
            }
        }
    }
    
    struct SectionViewModel: Hashable {
        let section: Section
        let items: [Item]
    }
    
    enum UIState {
        case loading
        case refreshing
        case success([SectionViewModel])
        case successDeletion(SectionViewModel)
        case failure(Home.HomeError)
    }
    
    enum HomeError: Error {
        case somethingWrong
    }
}

extension Home.HomeError: CustomDebugStringConvertible {
    var debugDescription: String {
        switch self {
        case .somethingWrong:
            return "Something went wrong"
        }
    }
}
