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
import AVFoundation

class HomeViewController: UIViewController, CLLocationManagerDelegate, MFMessageComposeViewControllerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager = CLLocationManager()
    var user = PFUser.current()
    var locations = [PFGeoPoint]()
    var listofUsers = [PFUser]()
    var arrayPhone = [String]()
    var membersPhone = ""
    var controller = MFMessageComposeViewController()
    var userLocation = String()
    var player: AVAudioPlayer? 
    
    //count down
    var alertController: UIAlertController!
    var counter:Int = 5
    var timer: Timer?
    

    
    @IBAction func emergencyButton(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Calling for Help?",
            message: "This will trigger an alarm sound and notify nearby users",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .destructive) { (action) in
            // return to homescreen
        }

        let confirmAction = UIAlertAction(
            title: "OK", style: .default) { (action) in
            self.playSound()
            self.saveNotification()
            self.counter = 5
            self.sendEmergencyText()
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter), userInfo: nil, repeats: true)
        }

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @objc func sendEmergencyText() {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            let current : PFGeoPoint = user!["Location"] as! PFGeoPoint
            let long = current.longitude.description
            let lat = current.latitude.description
            
            controller.body = "🚨🚨🚨 Please help me! I am in an emergency!\n📍Direct to my location:\n🗺 Google Map\nhttps://maps.google.com/?daddr=\(lat),\(long)&directionsmode=driving\n" + "🗺 Apple Map\nhttps://maps.apple.com/maps?daddr=\(lat),\(long)&dirflg=d"
            controller.recipients = arrayPhone
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
        else {
            print("Cannot send message")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true) {
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
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "iphone_alarm", withExtension: "mp3")
        else {
            print("url not found")
            return
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    @IBAction func notifyButton(_ sender: Any) {
        let alertController = UIAlertController(
            title: "Calling for Help?",
            message: "This will notify nearby users that you are feeling unsafe",
            preferredStyle: .alert
        )

        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .destructive) { (action) in
            // return to homescreen
        }

        let confirmAction = UIAlertAction(
            title: "OK", style: .default) { [self] (action) in
            self.saveNotification()
            self.counter = 5
            self.sendUnsafeText()
//            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounterNotification), userInfo: nil, repeats: true)
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveNotification() {
        let current : PFGeoPoint = user!["Location"] as! PFGeoPoint
        let long = current.longitude.description
        let lat = current.latitude.description
        let notification = PFObject(className: "Notification")
        notification["Message"] = "🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨🚨\nPlease help me! I am in an emergency!\n📍Direct to my location:\n🗺 Google Map\nhttps://maps.google.com/?daddr=\(lat),\(long)&directionsmode=driving\n" + "🗺 Apple Map\nhttps://maps.apple.com/maps?daddr=\(lat),\(long)&dirflg=d"
        notification["Author"] = PFUser.current()!
        notification.saveInBackground{(success, error) in
            if success {
                //self.dismiss(animated: true, completion: nil)
                print("Saved")
            }
            else
            {
                print ("Error")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

//    @objc func updateCounterNotification() {
//        if counter >= 0 {
//            counter -= 1
//        }
//        if counter == 0 {
//            timer?.invalidate()
//            print("COUNTER GOT TO ZERO")
//            dismiss(animated: true, completion: nil)
//
//            let alertController = UIAlertController(
//                title: "Notification Sent",
//                message: "We have let nearby users know that you are feeling unsafe.",
//                preferredStyle: .alert
//            )
//
//            let cancelAction = UIAlertAction(
//                title: "Cancel",
//                style: .destructive) { (action) in
//                // return to homescreen
//            }
//
//            let confirmAction = UIAlertAction(
//                title: "OK", style: .default) { (action) in
//                // ...
//            }
//
//            alertController.addAction(confirmAction)
//            alertController.addAction(cancelAction)
//            self.present(alertController, animated: true, completion: nil)
//        }
//    }
    
    func sendUnsafeText() {
        if (MFMessageComposeViewController.canSendText()) {
                   let controller = MFMessageComposeViewController()
                   let current : PFGeoPoint = user!["Location"] as! PFGeoPoint
                   let long = current.longitude.description
                   let lat = current.latitude.description
                
                   controller.body = "🚨🚨🚨 Please help me! I am in an emergency!\n📍Direct to my location:\n🗺 Google Map\nhttps://maps.google.com/?daddr=\(lat),\(long)&directionsmode=driving\n" + "🗺 Apple Map\nhttps://maps.apple.com/maps?daddr=\(lat),\(long)&dirflg=d"
                   controller.recipients = arrayPhone
                   controller.messageComposeDelegate = self
                   self.present(controller, animated: true, completion: nil)
    }
                else {
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
        
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "Me"
        mapView.addAnnotation(pin)
    }
    
    func displayPin (_ location: PFGeoPoint, _ username: String) {
        let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        //pin.title = username
        print(username + "adds pin")
        mapView.addAnnotation(pin)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
      
        self.arrayPhone = user?["contactPhone"] as! [String]
        
        //let userGeoPoint = (user?["location"]) as! PFGeoPoint
        let query = PFUser.query()
        //query?.whereKey("Location", nearGeoPoint:userGeoPoint)
        query?.findObjectsInBackground(block: {
            objects, error in
            if let listofUsers = objects {
                for object in listofUsers {
                    if (object["username"] as? String != self.user?.username)
                        {
                            if (object["Location"] != nil)
                            {
                                let location = object["Location"] as! PFGeoPoint
                                print(location)
                                print("Getting location!")
                                self.displayPin(location, object["username"] as! String)
                            }
                        }
                        else
                        {
                            print("Error getting location!")
                        }
                    }
            };
    })
    }
}
