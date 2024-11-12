//
//  RequestManager.swift
//  DemoApp
//
//  Created by Anton Ivchenko on 19.08.2024.
//

import Foundation

struct RequestManager: PRequestManagerProvider {
    // MARK: - Properties
    private let taskManager: PTaskManager
    // MARK: - Initializer
    init(taskManager: PTaskManager = TaskManager.shared) {
        self.taskManager = taskManager
    }
    // MARK: Send request
    func sendRequest(_ data: PEndpointData, requestAsyncType: RequestAsyncType = .async) {
        Task {
            switch requestAsyncType {
            case .sync: await sendSerialRequest(data)
            case .async: await sendConcurrentRequest(data)
            }
        }
    }
    // MARK: - Private methods
    private func sendSerialRequest(_ requestData: PEndpointData) async {
        await commonSendRequest(requestData, isConcurrent: false)
    }
    private func sendConcurrentRequest(_ requestData: PEndpointData) async {
        await commonSendRequest(requestData, isConcurrent: true)
    }
    private func commonSendRequest(_ requestData: PEndpointData, isConcurrent: Bool) async {
        let request = URLRequest.buildRequest(endpointData: requestData)
        let sendConcurrentRequest = await taskManager.sendConcurrentRequest(request)
        let sendSerialRequest = await taskManager.sendSerialRequest(request)
        let result = isConcurrent ? sendConcurrentRequest : sendSerialRequest
        handleRequestResult(result, requestData: requestData)
    }
    private func handleRequestResult(_ result: NetworkResult, requestData: PEndpointData) {
        switch result {
        case .success(let data, let response):
            let statusCode = handleResponse(response)
            requestData.handleResponseResult(.success(data: data, statusCode: statusCode))
        case .error(let error):
            handleError(error as NSError)
            requestData.handleResponseResult(.error(error))
        }
    }
    private func handleResponse(_ response: URLResponse?) -> HTTP.StatusCode? {
        guard let response = response as? HTTPURLResponse else { return nil }
        let statusCode = HTTP.StatusCode(response.statusCode)
        if statusCode.isUnknownError {
            debugPrint("Something Went Wrong!")
        } else {
            handleStatusCode(statusCode.codeType)
        }
        return statusCode
    }
    private func handleStatusCode(_ statusCode: HTTP.StatusCode.CodeType) {
        switch statusCode {
        case .badRequest,
             .notFound,
             .internalError:            debugPrint("Something Went Wrong!")
        case .sessionExpiredOrNotExist: debugPrint("Session Expired Or Not Exist!")
        default: break
        }
    }
    private func handleError(_ error: NSError) {
        switch error.code {
        case NSURLErrorNotConnectedToInternet, NSURLErrorDataNotAllowed:
            debugPrint("No Internet!")
        case NSURLErrorTimedOut:
            debugPrint("Time Out!")
        case NSURLErrorSecureConnectionFailed:
            debugPrint("Secure Connection Failed!")
        case NSURLErrorCancelled:
            debugPrint("Request was cancelled!")
        default:
            debugPrint("Something Went Wrong!")
        }
    }
}
