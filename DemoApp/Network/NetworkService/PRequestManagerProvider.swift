//
//  PRequestManagerProvider.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Foundation

/// This protocol defines the requirements for an object that provides functionality for sending network requests.
protocol PRequestManagerProvider {
    func sendRequest(_ data: PEndpointData, requestAsyncType: RequestAsyncType)
}
