//
//  NotifyTravelTaskMapVC.swift
//  BuildFoundation
//
//  Created by ismayil-16441 on 18/02/23.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class NotifyTravelTaskMapVC : UIViewController {
    
    private var mapView : MKMapView = {
        let map = MKMapView(frame: .zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(mapView)
        self.locationManager.requestAlwaysAuthorization()

        NSLayoutConstraint.activate([
        
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 50),
        
        ])
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.startUpdatingLocation()
                }

            self.mapView.delegate = self
            self.mapView.mapType = .standard
            self.mapView.isZoomEnabled = true
            self.mapView.isScrollEnabled = true

            if let coor = self.mapView.userLocation.location?.coordinate{
                self.mapView.setCenter(coor, animated: true)
                }
        }
        
    }
}

extension NotifyTravelTaskMapVC : CLLocationManagerDelegate,MKMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
//            mapView.setCameraZoomRange(, animated: true)
            self.mapView.setCenter(location.coordinate, animated: true)
        }
    }
}
