import Foundation

protocol APIService: Service {
    func categories(
        completionHandler: @escaping (Result<CategoriesRequest.Response, APIServiceImpl.Error>) -> Void
    )
    
    func contentGroups(
        completionHandler: @escaping (Result<[ContentGroupsRequest.Response], APIServiceImpl.Error>) -> Void
    )
    
    func promotions(
        completionHandler: @escaping (Result<PromotionsRequest.Response, APIServiceImpl.Error>) -> Void
    )
}
