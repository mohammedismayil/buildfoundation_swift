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
    
    var addLocationBtn:ThemeAddButton = {
        let btn = ThemeAddButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    private let locationNotificationScheduler = LocationNotificationScheduler()
    
    
    override func viewDidLoad() {
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(mapView)
        self.view.addSubview(addLocationBtn)
        addLocationBtn.addTarget(self, action: #selector(addLocationNotification), for: .touchUpInside)
        locationNotificationScheduler.delegate = self

//        self.locationManager.requestAlwaysAuthorization()

        NSLayoutConstraint.activate([
        
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 200),
            addLocationBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            addLocationBtn.widthAnchor.constraint(equalToConstant: 100),
            addLocationBtn.heightAnchor.constraint(equalToConstant: 50),
            addLocationBtn.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
        
        ])
//        DispatchQueue.global().async {
//            if CLLocationManager.locationServicesEnabled() {
//                self.locationManager.delegate = self
//                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//                self.locationManager.startUpdatingLocation()
//                }
//
//            self.mapView.delegate = self
//            self.mapView.mapType = .standard
//            self.mapView.isZoomEnabled = true
//            self.mapView.isScrollEnabled = true
//
//            if let coor = self.mapView.userLocation.location?.coordinate{
//                self.mapView.setCenter(coor, animated: true)
//                }
//        }
        
    }
    
    @objc func addLocationNotification(){
        let notificationInfo = LocationNotificationInfo(notificationId: "nyc_promenade_notification_id",
                                                        locationId: "mumbai_location",
                                                        radius: 2000,
                                                        latitude: 37.335400,
                                                        longitude: -122.009201,
                                                        title: "Welcome to the Mumbai,India !",
                                                        body: "Tap to see more information",
                                                        data: ["location": "NYC Brooklyn Promenade"])
        
        locationNotificationScheduler.requestNotification(with: notificationInfo)
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

extension NotifyTravelTaskMapVC: LocationNotificationSchedulerDelegate {
    
    func locationPermissionDenied() {
        let message = "The location permission was not authorized. Please enable it in Settings to continue."
        presentSettingsAlert(message: message)
    }
    
    func notificationPermissionDenied() {
        let message = "The notification permission was not authorized. Please enable it in Settings to continue."
        presentSettingsAlert(message: message)
    }
    
    func notificationScheduled(error: Error?) {
        if let error = error {
            let alertController = UIAlertController(title: "Notification Schedule Error",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Notification Scheduled!",
                                                    message: "You will be notified when you are near the location!",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "nyc_promenade_notification_id" {
            let notificationData = response.notification.request.content.userInfo
            let message = "You have reached \(notificationData["location"] ?? "your location!")"
            
            let alertController = UIAlertController(title: "Welcome!",
                                                    message: message,
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true)
        }
        completionHandler()
    }
    
    private func presentSettingsAlert(message: String) {
        let alertController = UIAlertController(title: "Permissions Denied!",
                                                message: message,
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (alertAction) in
            if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSettings)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        present(alertController, animated: true)
    }
}
