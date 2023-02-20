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
    
    private let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(mapView)
        self.view.addSubview(addLocationBtn)
        addLocationBtn.addTarget(self, action: #selector(addLocationNotification), for: .touchUpInside)
        locationManager.delegate = self
        DispatchQueue.global().async {
            self.locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled() {
              // your code here
                self.locationManager.allowsBackgroundLocationUpdates = true
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.startMonitoringSignificantLocationChanges()
                self.locationManager.startUpdatingLocation()
                self.locationManager.allowsBackgroundLocationUpdates = true
                self.locationManager.delegate = self
              }
        }
//        locationNotificationScheduler.delegate = self

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
        let notificationInfo = LocationNotificationInfo(notificationId: "changeID",
                                                        locationId: "mumbai_location",
                                                        radius: 2000,
                                                        latitude: 8.979190357456387,
                                                        longitude: 77.29608919452437,
                                                        title: "Welcome to the Mumbai,India !",
                                                        body: "Tap to see more information",
                                                        data: ["location": "NYC Brooklyn Promenade"])
        
//        locationNotificationScheduler.requestNotification(with: notificationInfo)
        
        let notification = notificationContent()
//        let destRegion = destinationRegion(notificationInfo: notificationInfo)
        let center = CLLocationCoordinate2D(latitude: 37.335400, longitude: -122.009201)
        let region = CLCircularRegion(center: center, radius: 2000.0, identifier: "Headquarters")
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
//        let trigger = UNLocationNotificationTrigger(region: destRegion, repeats: true)
        
        let request = UNNotificationRequest(identifier: notificationInfo.notificationId,
                                            content: notification,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { [weak self] (error) in
            
        }
    }
    func notificationContent() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "You've reached"
        content.body = "Great"

        return content
    }
    
    func destinationRegion(notificationInfo: LocationNotificationInfo) -> CLCircularRegion {
        let destRegion = CLCircularRegion(center: notificationInfo.coordinates,
                                          radius: notificationInfo.radius,
                                          identifier: notificationInfo.locationId)
        destRegion.notifyOnEntry = true
        destRegion.notifyOnExit = true
        return destRegion
    }
    
    
    @objc func remindNotification(){
        var referenceDate = Calendar.current.date(byAdding: .second, value: 5, to: Date())!
        for i in 0...2 { // one every 5 seconds, so total = 12
            let content = UNMutableNotificationContent()
            content.title = "Hey Ismayil Wake up \(i)"
            content.body = "Body"

            var dateComponents = DateComponents(calendar: Calendar.current)
            // 5 seconds interval here but you can set whatever you want, for hours, minutes, etc.
            dateComponents.second = 5
            //dateComponents.hour = X
            // [...]
            
            guard let nextTriggerDate = dateComponents.calendar?.date(byAdding: dateComponents, to: referenceDate),
                  let nextTriggerDateCompnents = dateComponents.calendar?.dateComponents([.second], from: nextTriggerDate) else {
                return
            }
            referenceDate = nextTriggerDate

            print(nextTriggerDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: nextTriggerDateCompnents, repeats: true)
            let request = UNNotificationRequest(identifier: "notif-\(i)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
        }
    }
}

extension NotifyTravelTaskMapVC : CLLocationManagerDelegate,MKMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            print("Latitude \(location.coordinate.latitude)- \(location.coordinate.longitude)")
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
