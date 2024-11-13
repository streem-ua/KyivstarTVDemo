//
//  Token.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

public final class Token {
    let tokenString: String
    
    var authorizationHeader: Network.Header {
        .authorization("Bearer \(tokenString)")
    }
    
    public init(tokenString: String) {
        self.tokenString = tokenString
    }
}
