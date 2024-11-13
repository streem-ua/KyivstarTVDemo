//
//  Network.swift
//  NetworkLayer
//
//  Created by Vladyslav Lysenko on 27.08.2024.
//

import Alamofire

final public class Network {
    // MARK: - Typealiases
    public typealias ResponseResult = Result<Response, Error>
    public typealias Request = Alamofire.Request
    public typealias Completion = (ResponseResult) -> Void
    public typealias Method = Alamofire.HTTPMethod
    public typealias Header = HTTPHeader
    public typealias Headers = HTTPHeaders
    
    // MARK: - Public Properties
    public class var defaultHeaders: Headers {
        with(.default) { $0.add(.defaultAccept) }
    }

    // MARK: - Private Properties
    private let session: Alamofire.Session
    private let baseURL: URL
    private let plugins: [NetworkPlugin]
    private var isInternetAvailable: Bool {
        NetworkReachabilityManager(host: baseURL.absoluteString)?.isReachable == true
    }

    // MARK: - Initialize
    public init(baseURL: URL, plugins: [NetworkPlugin] = [], commonHeaders: Headers = defaultHeaders) {
        self.baseURL = baseURL
        self.plugins = plugins
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.headers = commonHeaders
        session = Alamofire.Session(
            configuration: configuration,
            startRequestsImmediately: false
        )
    }

    // MARK: - Public Methods
    @discardableResult
    func request(
        _ target: RequestConvertible,
        qos: DispatchQoS.QoSClass = .default,
        progress: ((Double) -> Void)? = nil,
        completion: @escaping Completion
    ) -> Cancellable {
        performRequest(
            CachedRequestConvertible(target),
            queue: .global(qos: qos),
            progress: progress,
            completion: completion
        )
    }

    // MARK: - Private Methods
    private func performRequest(
        _ target: RequestConvertible,
        queue: DispatchQueue,
        progress: ((Double) -> Void)? = nil,
        completion: @escaping Completion
    ) -> Cancellable {
        let token = CancellableToken()
        let commonCompletion: Completion = { [weak self] result in
            guard let self else { return }
            let result = self.process(result, target: target)
            completion(result)
        }

        do {
            let urlRequest = try makeURLRequest(for: target)
            return performData(
                urlRequest,
                token: token,
                queue: queue,
                target: target,
                completion: commonCompletion
            )
        } catch {
            queue.async {
                guard !token.isCancelled else { return }
                commonCompletion(.failure(error))
            }
            return token
        }
    }
    
    private func performData(
        _ request: URLRequest,
        token: CancellableToken,
        queue: DispatchQueue,
        target: RequestConvertible,
        completion: @escaping Completion
    ) -> Cancellable {
        let task = session
            .request(request)
            .responseData(queue: queue) { responseData in
                guard !token.isCancelled else { return }
                guard let response = responseData.response else {
                  return completion(.failure(self.performError(responseData.error)))
                }
                completion(Result { Response(data: responseData.data ?? Data(), response: response) })
            }
        token.didCancel {
            task.cancel()
        }
        task.resume()

        return token
    }

    private func makeBaseURL(for target: RequestConvertible) throws -> URL {
        target.baseURL ?? baseURL
    }

    private func makeURLRequest(for target: RequestConvertible) throws -> URLRequest {
        let url = try makeBaseURL(for: target)
            .appendingPathComponent(target.path)
            .appendingPathComponent(target.suffix)
        var request = try URLRequest(url: url).encoded(for: target)
        request.httpMethod = target.method.rawValue
        target.headers?.dictionary.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return try prepare(request, target: target)
    }
    
    private func performError(_ error: Error?) -> NetworkError {
        isInternetAvailable ? NetworkError(error) : NetworkError.noInternetConnection
    }
}

// MARK: - Handle NetworkPlugin methods
extension Network {
    private func prepare(_ request: URLRequest, target: RequestConvertible) throws -> URLRequest {
        try plugins.reduce(request) { try $1.prepare($0, target: target) }
    }

    private func process(_ result: Network.ResponseResult, target: RequestConvertible) -> Network.ResponseResult {
        plugins.reduce(result) { $1.process($0, target: target) }
    }
}
