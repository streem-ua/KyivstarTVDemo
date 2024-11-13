//
//  ISODateCoder.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

final class ISODateCoder: DateCoder {
    override class var formatter: DateFormatter? { .iso8601 }
}
