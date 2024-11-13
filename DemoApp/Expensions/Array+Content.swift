//
//  Array+Content.swift
//  DemoApp
//
//  Created by Vlad Tkach on 17.08.2024.
//

import Foundation

extension Array {
    
    func safeAt(_ index: Int) -> Element? {
        guard index >= 0 && index < count else {
            return nil
        }
        return self[index]
    }
}

public extension Array {
    subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
