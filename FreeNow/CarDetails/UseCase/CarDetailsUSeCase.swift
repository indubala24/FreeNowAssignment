//
//  CarDetailsUSeCase.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 12/03/22.
//

import Foundation

protocol CarDetailsUSeCase {
    func fetchCarDetailsFromLatitdeLongitude(_ latlongRequestData: LatLongInfoRequestModel,
                                             completionHandler: @escaping ApiServiceCompletionHandler<CarDetailsAPIResponseModel>)
}
