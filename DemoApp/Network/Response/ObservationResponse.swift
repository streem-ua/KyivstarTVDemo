//
//  ObservationResponse.swift
//  WeatherNation
//
//  Created by Misha on 29.03.2022.
//

import Foundation

struct ObservationResponse<T: Decodable>: Decodable {
    var success: Bool
    var observation: T
    var error: String?
    var errorcode: String?
}
