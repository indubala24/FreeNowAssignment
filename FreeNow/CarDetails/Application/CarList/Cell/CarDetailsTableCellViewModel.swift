//
//  CarDetailsTableCellViewModel.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 13/03/22.
//

import Foundation
import UIKit

class CarDetailsTableCellViewModel {
    let data: CarDetailsResponseModel
    init(data: CarDetailsResponseModel) {
        self.data = data
    }

    var carID: String {
        return String(data.id)
    }

    var carType: String {
        return data.type.uppercased()
    }

    var state: String {
        return data.state
    }

    var heading: String {
        return String(data.heading)
    }

    var latLong: String {
        return "Latitude: \(data.coordinate.latitude) \nLongitude: \(data.coordinate.longitude)"
    }

    var stateLabelColor: UIColor {
        return data.state.uppercased() == "ACTIVE" ? UIColor.systemGreen : UIColor.red
    }
}
