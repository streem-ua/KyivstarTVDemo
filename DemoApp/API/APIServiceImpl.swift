import Foundation

final class APIServiceImpl {
    
    enum Error: Swift.Error {
        case decodingError
        case `internal`
    }
    
    private let networkService: NetworkService
    private let decoder: JSONDecoder
    
    init(
        networkService: NetworkService,
        decoder: JSONDecoder
    ) {
        self.networkService = networkService
        self.decoder = JSONDecoder()
    }
    
    fileprivate func decodeResult<T: Decodable>(
            incomingResult: Result<Data?, Swift.Error>
    ) -> Result<T, Error> {
        
        switch incomingResult {
        case .success(let data) where data != nil:
            if let singleResponse = try? decoder.decode(T.self, from: data!) {
                return .success(singleResponse)
            }
            return .failure(.decodingError)
        default:
            return .failure(.internal)
        }
    }
        
}

extension APIServiceImpl: APIService {
    func promotions(
        completionHandler: @escaping (Result<PromotionsRequest.Response, APIServiceImpl.Error>) -> Void
    ) {
        let request = PromotionsRequest()
        networkService.request(request) { [unowned self] result in
            completionHandler(
                self.decodeResult(incomingResult: result)
            )
        }
    }
    
    func categories(
        completionHandler: @escaping (Result<CategoriesRequest.Response, Error>) -> Void
    ) {
        let request = CategoriesRequest()
        networkService.request(request) { [unowned self] result in
            completionHandler(
                self.decodeResult(incomingResult: result)
            )
        }
    }
    
    func contentGroups(
        completionHandler: @escaping (Result<[ContentGroupsRequest.Response], Error>) -> Void
    ) {
        let request = ContentGroupsRequest()
        networkService.request(request) { [unowned self] result in
            completionHandler(
                self.decodeResult(incomingResult: result)
            )
        }
    }
}
