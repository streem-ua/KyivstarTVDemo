//
//  AtomicBool.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

final class AtomicBool: ExpressibleByBooleanLiteral {
    private var storage: UnsafeMutablePointer<Int32> = .allocate(capacity: 1)

    var value: Bool {
        get {
            storage.pointee != 0
        }
        set {
            OSAtomicCompareAndSwap32Barrier(value ? 1 : 0, newValue ? 1 : 0, storage)
        }
    }
    
    public required init(booleanLiteral value: Bool) {
        storage.initialize(to: value ? 1 : 0)
    }

    deinit {
        storage.deinitialize(count: 1)
        storage.deallocate()
    }
}
