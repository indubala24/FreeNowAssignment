//
//  CarDetailsRepository.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 12/03/22.
//

import Foundation

class CarDetailsRepository {
    private var service: CarDetailsServiceProtocol

    init(with service: CarDetailsServiceProtocol) {
        self.service = service
    }
}

extension CarDetailsRepository: CarDetailsUSeCase {
    func fetchCarDetailsFromLatitdeLongitude(_ latlongRequestData: LatLongInfoRequestModel,
                                             completionHandler: @escaping ApiServiceCompletionHandler<CarDetailsAPIResponseModel>) {
        service.carDetailsWithLatLongData(latLongData: latlongRequestData) { result in
            switch result {
            case .success(let response):
                completionHandler(ApiServiceResult.success(response))
            case .failure(let error):
                completionHandler(ApiServiceResult.failure(error))
            }
        }
    }
}

