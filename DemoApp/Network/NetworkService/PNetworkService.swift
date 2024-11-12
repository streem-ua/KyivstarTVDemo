//
//  PNetworkService.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Combine

protocol PNetworkService: AnyObject {
    static var shared: PNetworkService { get }
    var requestManagerProvider: PRequestManagerProvider { get }
}

