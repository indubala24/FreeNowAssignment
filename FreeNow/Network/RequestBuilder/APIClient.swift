//
//  APIClient.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 12/03/22.
//

import Foundation
import Alamofire

typealias CompletionHandler = (Result) -> Void
typealias ApiServiceCompletionHandler<T> = (ApiServiceResult<T>) -> Void

enum Result {
    case success(_ jsonResponse: Any?)
    case failure(_ error: Any?)
}

enum ApiServiceResult<T> {
    case success(_ jsonResponse: T?)
    case failure(_ error: Any?)
}


class APIClient: NSObject {
    public static let sharedInstance : APIClient = APIClient.init()
    
    
    func performRequestWith(request : APIRequestBuilder, completionHandler : @escaping CompletionHandler) {
        print("[Request]:\n\(request.requestUrl)")
        AF.request(request.requestUrl, method: request.method, parameters: request.parameters, encoding: JSONEncoding.default, headers: request.headers) .responseJSON { response in
            switch response.result {
            case .success(_):
                completionHandler(Result.success(response.data))
            case .failure(let error):
                print(error.errorDescription as Any)
                completionHandler(Result.failure(error))
                break
            }
        }
    }
}

