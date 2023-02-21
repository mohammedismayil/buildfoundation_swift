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
    
    //    private let locationManager = CLLocationManager()
    
    var locationIndex = 0
    
    var locationsArr = [LocationNotificationInfo(notificationId: "location1",
                                                 locationId: "headquarters",
                                                 radius: 2000,
                                                 latitude: 9.873422,
                                                 longitude: 78.186352,
                                                 title: "Stop1",
                                                 body: "Tap to see more information",
                                                 data: ["location": "NYC Brooklyn Promenade"]),
                        LocationNotificationInfo(notificationId: "location2",
                                                 locationId: "headquarter2",
                                                 radius: 2000,
                                                 latitude: 9.897920920182221,
                                                 longitude: 78.15336650782756,
                                                 title: "Stop2",
                                                 body: "Tap to see more information",
                                                 data: ["location": "NYC Brooklyn Promenade"])]
    
    
    override func viewDidLoad() {
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        
        self.view.addSubview(mapView)
        self.view.addSubview(addLocationBtn)
        addLocationBtn.addTarget(self, action: #selector(addLocationNotification), for: .touchUpInside)
        locationNotificationScheduler.delegate = self
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
        
    }
    
    @objc func addLocationNotification(){
        let notificationInfo = locationsArr[locationIndex]
        
        locationIndex += 1
        
        locationNotificationScheduler.requestNotification(with: notificationInfo)
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
        if response.notification.request.identifier == "location1" {
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
