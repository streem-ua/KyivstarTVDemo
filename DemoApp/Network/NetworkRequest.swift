import Foundation

protocol NetworkRequest {
    associatedtype Body: Encodable
    
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var params: [String: String] { get }
    var body: Body? { get }
}
