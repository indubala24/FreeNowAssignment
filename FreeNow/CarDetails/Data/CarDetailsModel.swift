//
//  CarDetailsModel.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 12/03/22.
//

import Foundation

// Request Model
struct LatLongInfoRequestModel {
    let p1Lat: String
    let p1Long: String
    let p2Lat: String
    let p2Long: String
}

// Response Model
struct CarDetailsResponseModel: Codable {
    let id, heading: Double
    let coordinate: Coordinate
    let state, type: StringLiteralType
}

struct Coordinate: Codable {
    let latitude, longitude: Double
}

struct CarDetailsAPIResponseModel: Codable {
    let poiList: [CarDetailsResponseModel]
}
