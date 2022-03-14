//
//  BaseService.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 12/03/22.
//

import Foundation
import Alamofire

class BaseService {
    func makeApiCall<T: Decodable>(requestBuilder: APIRequestBuilder, responseType: T.Type, completionHandler: @escaping ApiServiceCompletionHandler<T>) {
        APIClient.sharedInstance.performRequestWith(request: requestBuilder) { [weak self] result in
            guard let self = self else { return }
            self.parseResponse(result, responseType: responseType, completionHandler: completionHandler)
        }
    }

    func parseResponse<T: Decodable>(_ result: Result,
                                     responseType: T.Type,
                                     completionHandler: @escaping ApiServiceCompletionHandler<T>) {
        switch (result) {
        case .success(let response):
            if let data = response as? Data {
                do {
                    let parsedModels = try JSONDecoder().decode(responseType.self, from: data)
                    completionHandler(ApiServiceResult.success(parsedModels))
                } catch(let error) {
                    completionHandler(ApiServiceResult.failure(error))
                }
            }
        case .failure(let error):
            completionHandler(ApiServiceResult.failure(error))
        }
    }
}
