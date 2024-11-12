//
//  PHomeNetworkRepository.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 20.08.2024.
//

import Combine

protocol PHomeNetworkRepository: AnyObject {
    func getContentGroup() -> AnyPublisher<NetResult<[ContentGroup]?>, Never>
    func getPromotions() -> AnyPublisher<NetResult<[Promotion]?>, Never>
    func getCategory() -> AnyPublisher<NetResult<[Category]?>, Never>
}
