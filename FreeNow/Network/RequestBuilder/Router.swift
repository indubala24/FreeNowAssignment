//
//  Router.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 12/03/22.
//

import Foundation
import Alamofire

enum APIRequestBuilder {
    case getCarDetails(latlongInfo: LatLongInfoRequestModel)
}

struct BaseURL {
    static let baseUrlString = "https://poi-api.mytaxi.com/PoiService/poi/v1?p1Lat=%@&p1Lon=%@&p2Lat=%@&p2Lon=%@"
}
extension APIRequestBuilder {
    var method: HTTPMethod {
        switch self {
        case .getCarDetails:
            return .get
        }
    }
}

extension APIRequestBuilder {
    private func endPoint() -> String {
        switch self {
        case let .getCarDetails(latlongInfo):
            return String(format: BaseURL.baseUrlString,
                          latlongInfo.p1Lat,
                          latlongInfo.p1Long,
                          latlongInfo.p2Lat,
                          latlongInfo.p2Long)
        }
    }
    
    var requestUrl: String {
        switch self {
        case .getCarDetails:
            return endPoint()
        }
    }
        
}

extension APIRequestBuilder {
    var headers: HTTPHeaders {
        return [:]
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getCarDetails:
            return nil
        }
    }
}

