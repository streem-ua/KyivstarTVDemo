//
//  AssetDetailsModel.swift
//  DemoApp
//
//  Created by Vlad Tkach on 17.08.2024.
//

import Foundation

struct AssetDetailsModel: Decodable, Hashable {
    
    let id: String
    let name: String
    let image: String
    let company: String
    let duration: Int //seconds?
    let progress: Int
    let purchased: Bool
    let updatedAt: String
    let description: String
    let releaseDate: String
    
    let similar: [ContentGroup.Asset]
    
    var durationString: String {
        let (h, m, _) = secondsToHoursMinutesSeconds(duration)
        return "\(h) h, \(m) m"
    }
    
    var moviewGenreString: String {
        return "Andventure"
    }
    
    var releaseYearString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-hh-mm"
        if let date = dateFormatter.date(from: releaseDate) {
            return "\(date.component(.year))"
        } else {
            return "2020?"
        }
    }
    
    private func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }

}
