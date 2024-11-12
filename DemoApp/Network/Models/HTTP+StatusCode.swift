//
//  HTTP+StatusCode.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

extension HTTP {
    struct StatusCode {
        let rawCode: Int
        let codeType: CodeType
        /// Status code: 200...299
        var isSuccess: Bool { 200..<300 ~= rawCode }
        var isUnknownError: Bool {
            if rawCode >= 400 { return CodeType(rawValue: rawCode) == .undefined }
            return false
        }
        /// Status code: 500...599
        var isServerError: Bool {
            500...599 ~= rawCode
        }
        // MARK: - Init
        init(_ code: Int) {
            rawCode = code
            codeType = CodeType(rawValue: code)
        }
    }
}

extension HTTP.StatusCode {
    enum CodeType: Int, CaseIterable {
        /// StatusCode: 200
        case success                  = 200
        /// StatusCode: 202
        case accepted                 = 202
        /// StatusCode: 400
        case badRequest               = 400
        /// StatusCode: 401. Session expired or not exist
        case sessionExpiredOrNotExist = 401
        /// StatusCode: 404
        case notFound                 = 404
        /// StatusCode: 500. Internal server error
        case internalError            = 500
        case undefined                = -1
        // MARK: - Initializer
        public init(rawValue: Int) {
            let type = CodeType.allCases.first(where: { $0.rawValue == rawValue })
            self = type ?? .undefined
        }
    }
}
