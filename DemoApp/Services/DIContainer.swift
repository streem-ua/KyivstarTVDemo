import Foundation

final class DIContainer {
    
    static let shared = DIContainer()
    
    private lazy var urlSession = URLSession.shared
    private lazy var encoder = JSONEncoder()
    private lazy var decoder = JSONDecoder()
    private lazy var networkService: NetworkService = NetworkServiceImpl(session: urlSession, encoder: encoder)
    
    lazy var apiService: APIService = APIServiceImpl(networkService: networkService, decoder: decoder)
}
