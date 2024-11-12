//
//  ResponseResult.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

enum ResponseResult {
    case success(data: Data?, statusCode: HTTP.StatusCode?)
    case error(Error)
}
