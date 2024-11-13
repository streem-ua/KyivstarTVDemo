//
//  NetworkResponse.swift
//  WeatherNation
//
//  Created by Alex Hafros on 04.11.2021.
//

import Foundation

struct NetworkResponse<T: Decodable>: Decodable {
    var success: Bool
    var response: T
    var error: String?
    var errorcode: String?
}
