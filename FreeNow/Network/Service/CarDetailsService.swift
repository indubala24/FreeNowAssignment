//
//  CarDetailsService.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 12/03/22.
//

import Foundation

protocol CarDetailsServiceProtocol {
    func carDetailsWithLatLongData(latLongData: LatLongInfoRequestModel, completionHandler: @escaping ApiServiceCompletionHandler<CarDetailsAPIResponseModel>)
}

class CarDetailsService: BaseService, CarDetailsServiceProtocol { }

extension CarDetailsService {
    func carDetailsWithLatLongData(latLongData: LatLongInfoRequestModel, completionHandler: @escaping ApiServiceCompletionHandler<CarDetailsAPIResponseModel>) {
        let apiRequestBuilder = APIRequestBuilder.getCarDetails(latlongInfo: latLongData)
        self.makeApiCall(requestBuilder: apiRequestBuilder, responseType: CarDetailsAPIResponseModel.self) { result in
            switch result {
            case .success(let response):
                if let response = response {
                    completionHandler(ApiServiceResult.success(response))
                } else {
                    completionHandler(ApiServiceResult.success(nil))
                }
            case .failure(let error):
                completionHandler(ApiServiceResult.failure(error))
                
                
            }
        }
    }
}
