//
//  Network+Headers.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

extension Network.Header {
    static func accept(contentTypes: [String]) -> Network.Header {
        Network.Header(name: "Content-Type", value: contentTypes.joined(separator: "; "))
    }
    
    static var defaultAccept: Network.Header {
        accept(contentTypes: ["application/json"])
    }
}
