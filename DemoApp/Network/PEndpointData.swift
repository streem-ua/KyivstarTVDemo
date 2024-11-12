//
//  PEndpointData.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

protocol PEndpointData {
    // MARK: - Properties
    var urlPath: PURLPath { get }
    var method: HTTP.Method { get }
    var header: HTTP.Header? { get }
    var body: HTTP.Body? { get }
    var contentType: HTTP.ContentType { get }
    // MARK: - Methods
    func handleResponseResult(_ responseResult: ResponseResult)
}

// MARK: - Default values -
extension PEndpointData {
    // MARK: - Properties
    var header: HTTP.Header? { nil }
    var isNeedToAddBaseBody: Bool { false }
    var contentType: HTTP.ContentType { HTTP.ContentType.json }
    var version: String { "" }
    var requestTimeout: TimeInterval? { nil }
}

extension PEndpointData {
    typealias IsSuccessCompletion                 = (_ isSuccess: Bool) -> Void
    typealias IsSuccessWithDataCompletion<T>      = (_ isSuccess: Bool, _ data: T) -> Void
}
