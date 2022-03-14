//
//  CarInMapViewController.swift
//  FreeNow
//
//  Created by Indubala Jayachandran on 14/03/22.
//

import UIKit
import MapKit

class CarInMapViewController: UIViewController {

    var viewModel: CarDetailViewModel?
    @IBOutlet weak var viewListButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!

    var resetdata: ((Any?)-> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setUpMapDelegate()
        setUpUI()
        setUpMapView()
    }

    private func setUpUI() {
        viewListButton.layer.borderColor = UIColor.systemBlue.cgColor
        viewListButton.setTitleColor(UIColor.systemBlue, for: .normal)
        viewListButton.layer.borderWidth = 1.0
        viewListButton.layer.cornerRadius = 8.0
    }

    private func setUpMapDelegate() {
        mapView.delegate = self
    }

    private func bindUI() {
        viewModel?.showSpinner = { [weak self] (show) in
            guard let self = self else { return }
            show ? self.addSpinner() : self.removeSpinner()
        }

        viewModel?.reloadDataHandler = { [weak self] (annotationArray) in
            guard let self = self else { return }
            self.removeSpinner()
            guard let annotationArray = annotationArray as? [MKPointAnnotation] else { return }
            self.addAnnotation(annotationArray: annotationArray)
        }
    }

    private func setUpMapView() {
        mapViewDidFinishLoadingMap(mapView: mapView)
        guard let annotationArray = viewModel?.annotationForRegion() else { return }
        self.addAnnotation(annotationArray: annotationArray)
    }

    private func addAnnotation(annotationArray: [MKPointAnnotation]) {
        for annotation in annotationArray {
            mapView.addAnnotation(annotation)
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }

    @IBAction func didTapViewInList(_ sender: Any) {
        resetdata?(true)
        self.dismiss(animated: true, completion: nil)
    }

    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        guard let mapRegion = viewModel?.mapRegion() else { return }
        mapView.setVisibleMapRect(mapRegion, animated: true)
    }
}


extension CarInMapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if viewModel?.isLocationChanged(centerCoordinate: mapView.centerCoordinate) ?? false {
            viewModel?.setRequestModelFrom(mapRegion: mapView.visibleMapRect)
        }
    }
}
