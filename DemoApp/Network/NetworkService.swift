import Foundation

protocol NetworkService: Service {
    @discardableResult
    func request<R: NetworkRequest>(
        _ request: R,
        completionHandler: @escaping (Result<Data?, Error>) -> Void
    ) -> URLSessionDataTask
}
