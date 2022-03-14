//
//  Extension.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 14/03/22.
//

import UIKit
import MapKit

extension UIViewController {
    static func instantiateFromStoryBoard(_ storyBoard: Storyboard) -> Self {
        let controller = storyBoard.instantiateVC(self)
        controller.edgesForExtendedLayout = []
        return controller
    }

    func addSpinner() {
        let child = SpinnerViewController()
        child.view.frame = view.frame
        child.view.tag = 1001
        view.addSubview(child.view)
    }

    func removeSpinner() {
        for subview in self.view.subviews where subview.tag == 1001 {
            subview.removeFromSuperview()
        }
    }
}

extension NSObject {
    /**
     Variable to get class name
     - returns: Returns class name string
     */
    var className: String {
        return String(describing: type(of: self))
    }
    /**
     Class variable to get class name
     - returns: Returns class name string
     */
    class var className: String {
        return String(describing: self)
    }
}


extension UITableView {
    func registerCellWithNib<T: UITableViewCell>(forCell cellType: T.Type ) {
        self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self).lowercased())
    }
}

extension MKMapView {
    func centerToLocation(
      _ location: CLLocation,
      regionRadius: CLLocationDistance = 1000
    ) {
      let coordinateRegion = MKCoordinateRegion(
        center: location.coordinate,
        latitudinalMeters: regionRadius,
        longitudinalMeters: regionRadius)
      setRegion(coordinateRegion, animated: true)
    }
  }
