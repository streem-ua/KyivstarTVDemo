import Foundation

final class NetworkServiceImpl {
    private let session: URLSession
    private let encoder: JSONEncoder
    
    init(session: URLSession, encoder: JSONEncoder) {
        self.session = session
        self.encoder = encoder
    }
}

extension NetworkServiceImpl: NetworkService {
    
    @discardableResult
    func request<R>(
        _ request: R,
        completionHandler: @escaping (Result<Data?, Error>) -> Void
    ) -> URLSessionDataTask where R: NetworkRequest {
        var components = URLComponents(url: request.url, resolvingAgainstBaseURL: true)!
        var queryItems = [URLQueryItem]()
        for (key, value) in request.params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        components.queryItems = queryItems
        var urlRequest: URLRequest = URLRequest(url: components.url!)
        urlRequest.httpMethod = request.method.rawValue
        if let body = request.body {
            urlRequest.httpBody = try? encoder.encode(body)
        }
        for (key, value) in request.headers {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        let task = session.dataTask(with: urlRequest) { data, response, error  in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            completionHandler(.success(data))
        }
        defer { task.resume() }
        return task
    }
}
