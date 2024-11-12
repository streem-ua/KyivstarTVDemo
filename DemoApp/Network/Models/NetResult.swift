//
//  NetResult.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Foundation

struct NetResult<T> {
    let isSuccess: Bool
    let data: T?
}
