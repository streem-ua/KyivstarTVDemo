//
//   NSObject+.swift
//
//
//  Created by Vadim Marchenko on 11.04.2024.
//

import Foundation

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }

    public var className: String {
        return type(of: self).className
    }
}

extension NSObject: ClassNameProtocol { }

