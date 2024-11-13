//
//  ReleaseDateCoder.swift
//  DemoApp
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Foundation

final class ReleaseDateCoder: DateCoder {
    override class var formatter: DateFormatter? { .release }
}
