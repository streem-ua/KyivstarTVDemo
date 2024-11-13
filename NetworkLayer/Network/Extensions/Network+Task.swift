//
//  Network+Task.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Alamofire

extension Network {
    public enum Task {
        /// A request with no additional data.
        case requestPlain

        /// A requests body set with data.
        case requestData(Data)

        /// A requests body set with data, combined with url parameters.
        case requestCompositeData(bodyData: Data, urlParameters: [String: Any])

        /// A requests body set with encoded parameters combined with url parameters.
        case requestCompositeParameters(
            bodyParameters: [String: Any],
            bodyEncoding: ParameterEncoding,
            urlParameters: [String: Any] = [:]
        )
    }
}
