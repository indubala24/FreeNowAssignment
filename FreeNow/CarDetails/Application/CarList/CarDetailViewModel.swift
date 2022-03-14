//
//  CarDetailViewModel.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 12/03/22.
//

import Foundation
import MapKit

class CarDetailViewModel {
    let useCase: CarDetailsUSeCase
    var inMap: Bool = false
    var dataModel: [CarDetailsResponseModel] = []
    var reloadDataHandler: ((Any?)-> Void)?
    var showSpinner: ((Bool)->Void)?
    var requestModel = LatLongInfoRequestModel.init(p1Lat: "53.694865", p1Long: "9.757589", p2Lat: "53.394655", p2Long: "10.099891")
    var centreCoordinate: CLLocationCoordinate2D?
    init(useCase: CarDetailsUSeCase) {
        self.useCase = useCase
    }

    func fetchdata() {
        dataModel.removeAll()
        showSpinner?(true)
        requestModel = inMap ? requestModel : LatLongInfoRequestModel.init(p1Lat: "53.694865", p1Long: "9.757589", p2Lat: "53.394655", p2Long: "10.099891")
        useCase.fetchCarDetailsFromLatitdeLongitude(self.requestModel) { [weak self] result in
            guard let self = self else { return }
            self.showSpinner?(false)
            switch result {
            case .success(let response):
                if let dataResponseArray = response?.poiList {
                    self.dataModel = dataResponseArray
                }
            case .failure(let error):
                // Show toast
                if !self.inMap {
                    self.reloadDataHandler?(false)
                    return
                }
            }
            self.inMap ? self.reloadDataHandler?(self.annotationForRegion()) : self.reloadDataHandler?(true)
        }
    }

    var rowCount: Int {
        return dataModel.count
    }

    func getCarDetailsCellModelAtIndex(index: Int) -> CarDetailsTableCellViewModel {
        return CarDetailsTableCellViewModel(data: self.dataModel[index])
    }

    func mapRegion() -> MKMapRect? {
        let coordinate1 = CLLocationCoordinate2DMake(Double(requestModel.p1Lat) ?? 0, Double(requestModel.p1Long) ?? 0)
        let coordinate2 = CLLocationCoordinate2DMake(Double(requestModel.p2Lat) ?? 0, Double(requestModel.p2Long) ?? 0)
        // convert them to MKMapPoint
        let p1 = MKMapPoint(coordinate2)
        let p2 = MKMapPoint(coordinate1)
        return MKMapRect.init(x: fmin(p1.x,p2.x), y: fmin(p1.y,p2.y), width: fabs(p1.x-p2.x), height: fabs(p1.y-p2.y))
    }

    func annotationForRegion() -> [MKPointAnnotation] {
        var anotArray: [MKPointAnnotation] = []
        for data in dataModel {
            let anotPoint = MKPointAnnotation()
            anotPoint.title = String(data.heading)
            anotPoint.subtitle = data.type
            anotPoint.coordinate = CLLocationCoordinate2D(latitude: data.coordinate.latitude, longitude: data.coordinate.longitude)
            anotArray.append(anotPoint)
        }
        return anotArray
    }

    func setRequestModelFrom(mapRegion: MKMapRect) {
        let p1x = mapRegion.origin.x
        let p2x = fabs(mapRegion.size.width - p1x)
        let p1y = mapRegion.origin.y
        let p2y = fabs(mapRegion.size.height - p1y)
        let point1 = MKMapPoint(x: p1x, y: p1y)
        let point2 = MKMapPoint(x: p2x, y: p2y)

        requestModel = LatLongInfoRequestModel(p1Lat: "\(point1.coordinate.latitude)",
                                               p1Long: "\(point1.coordinate.longitude)",
                                               p2Lat: "\(point2.coordinate.latitude)",
                                               p2Long: "\(point2.coordinate.longitude)")
        fetchdata()
    }

    func isLocationChanged(centerCoordinate: CLLocationCoordinate2D) -> Bool {
        if self.centreCoordinate == nil {
            self.centreCoordinate = centerCoordinate
            return false
        }
        if self.centreCoordinate?.latitude == centerCoordinate.latitude &&
            self.centreCoordinate?.longitude == centerCoordinate.longitude {
            return false
        }
        return true
    }
}
