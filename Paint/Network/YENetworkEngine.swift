//
//  YENetworkEngine.swift
//  Paint
//
//  Created by yawei zhan on 2017/10/1.
//  Copyright © 2017年 YE. All rights reserved.
//

import Foundation
import Alamofire

public struct YEResponse<T> {
    var retCode: YEResult
    var responseObject: T?
    var error: Error?
}

public enum YEResult: Int {
    case success = 0
    case failure = -1
}


class YENetworkEngine {
    public static let engine: YENetworkEngine = YENetworkEngine()
    private init() {}
    
    public func request<T: Decodable>(
    _ url: URLConvertible,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    parameterEncoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil,
    handleQueue: DispatchQueue? = nil,
    options: JSONSerialization.ReadingOptions = .allowFragments,
    handleType: T.Type,
    completionHandler: @escaping (YEResponse<T>) -> Void) -> Void
    {
        Alamofire.request(url, method: method, parameters: parameters, encoding: parameterEncoding, headers: headers).responseJSON(queue: handleQueue, options: options) { (response) in
            var rResponse = YEResponse<T>(retCode: YEResult.success, responseObject: nil, error: nil)
            switch response.result {
            case .success:
                if let data = response.data {
                    if let obj = try? JSONDecoder().decode(handleType, from: data) {
                        rResponse.responseObject = obj
                    }
                } else {
                    rResponse.retCode = YEResult.failure
                    rResponse.error = self.createError(.jsonDecoderError, description: "json data convert to obj error", failureReason: "json data not fit object", recoverySuggestion: "check response json data and object path")
                }
            case .failure(let error):
                rResponse.retCode = YEResult.failure
                rResponse.error = error
            }
            completionHandler(rResponse)
        }
    }
    
}

extension YENetworkEngine {
    public static let errorDomain = "YENetworkEngineErrorDomain"
    public enum ErrorCode: Int {
        case jsonDecoderError                   = 0
        case responseDataError                  = 1
        case responseError                      = 2
    }
    
    fileprivate func createError(_ errorCode: ErrorCode, description: String?, failureReason: String?, recoverySuggestion: String?) -> Error {
        let errorInfo: [String: Any] = [NSLocalizedDescriptionKey : description ?? "",
                                        NSLocalizedRecoverySuggestionErrorKey: recoverySuggestion ?? "",
                                        NSLocalizedFailureReasonErrorKey: failureReason ?? ""]
        return NSError(domain: YENetworkEngine.errorDomain, code: errorCode.rawValue, userInfo: errorInfo) as Error
    }
}
