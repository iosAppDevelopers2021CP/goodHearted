//
//  HomeViewController.swift
//  GoodHearted
//
//  Created by Le Thuy on 4/21/21.
//
import MapKit
import UIKit
import CoreLocation
import Parse
import MessageUI

class HomeViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let user = PFUser.current()
    var locations = [PFGeoPoint]()
    var arrayPhone = [String]()
    var membersPhone = ""
    var controller = MFMessageComposeViewController()
    var userLocation = String()
    
    //count down
    var alertController: UIAlertController!
    var counter:Int = 5
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.arrayPhone = user?["contactPhone"] as! [String]
    }
    
    @IBAction func emergencyButton(_ sender: Any) {
        counter = 5
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
        sendEmergencyText()
    }
    
    func testPush(){
        let message = "Alert !!"
        let id = "yGUxJITfP3"

        let data = [ "title": "Some Title",
            "alert": message]

        let userQuery: PFQuery = PFUser.query()!
        userQuery.whereKey("objectId", equalTo: id)
        guard let query = PFInstallation.query() as? PFQuery<PFInstallation> else { return }
        query.whereKey("currentUser", matchesQuery: userQuery)

        let push: PFPush = PFPush()
        push.setQuery(query)
        push.setData(data)
        push.sendInBackground()
    }
    
    func sendEmergencyText() {
            if (MFMessageComposeViewController.canSendText()) {
                let controller = MFMessageComposeViewController()
                let current : PFGeoPoint = user!["Location"] as! PFGeoPoint
                let long = current.longitude.description
                let lat = current.latitude.description
                controller.body = "🚨🚨🚨 Please help me! I am in an emergency!\n📍Direct to my location:\n🗺 Google Map\nhttp://maps.google.com/?daddr=\(lat),\(long)&directionsmode=driving\n" + "🗺 Apple Map\nhttp://maps.apple.com/maps?daddr=\(lat),\(long)&dirflg=d"
                controller.recipients = arrayPhone
                controller.messageComposeDelegate = self
                self.present(controller, animated: true, completion: nil)
            } else {
                print("Cannot send message")
            }
        }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func updateCounter() {
        if counter >= 0 {
            counter -= 1
        }
        if counter == 0 {
            timer?.invalidate()
            print("COUNTER GOT TO ZERO")
            dismiss(animated: true, completion: nil)
            
            let alertController = UIAlertController(
                title: "Call 911?",
                message: "",
                preferredStyle: .alert
            )

            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .destructive) { (action) in
                // return to homescreen
            }

            let confirmAction = UIAlertAction(
                title: "OK", style: .default) { (action) in
                let url = URL(string: "tel://\(911)")
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url!, options: [:], completionHandler:nil)
                } else {
                    UIApplication.shared.openURL(url!)
                }
            }

            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func notifyButton(_ sender: Any) {
        //testPush()
        counter = 5
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounterNotification), userInfo: nil, repeats: true)

        sendUnsafeText()
    }
    
    @objc func updateCounterNotification() {
        if counter >= 0 {
            counter -= 1
        }
        if counter == 0 {
            timer?.invalidate()
            print("COUNTER GOT TO ZERO")
            dismiss(animated: true, completion: nil)
            
            let alertController = UIAlertController(
                title: "Notification Sent",
                message: "We have let nearby users know that you are feeling unsafe.",
                preferredStyle: .alert
            )

            let cancelAction = UIAlertAction(
                title: "Cancel",
                style: .destructive) { (action) in
                // return to homescreen
            }

            let confirmAction = UIAlertAction(
                title: "OK", style: .default) { (action) in
                // ...
            }

            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func sendUnsafeText() {
        if (MFMessageComposeViewController.canSendText()) {
                   let controller = MFMessageComposeViewController()
                   let current : PFGeoPoint = user!["Location"] as! PFGeoPoint
                   let long = current.longitude.description
                   let lat = current.latitude.description
                   controller.body = "🚨🚨🚨 Please help me! I am in an emergency!\n📍Direct to my location:\n🗺 Google Map\nhttp://maps.google.com/?daddr=\(lat),\(long)&directionsmode=driving\n" + "🗺 Apple Map\nhttp://maps.apple.com/maps?daddr=\(lat),\(long)&dirflg=d"
                   controller.recipients = arrayPhone
                   controller.messageComposeDelegate = self
                   self.present(controller, animated: true, completion: nil)
               } else {
                   print("Cannot send message")
               }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            let userLocation = PFGeoPoint(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            user?.setValue(userLocation, forKey: "Location")
            user?.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                print("object has been saved!")
              }
              else {
                print("object has not been saved! Error!")
              }
            }
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "Me"
        mapView.addAnnotation(pin)
    }
    
    func displayPin (_ location: PFGeoPoint) {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}
