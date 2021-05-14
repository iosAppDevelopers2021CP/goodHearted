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
class HomeViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let user = PFUser.current()
    var locations = [PFGeoPoint]()
    
    @IBAction func emergencyButton(_ sender: Any) {
        // Alert
        let optionMenu = UIAlertController(title: "Please Hang On", message: "Michael is coming to assist you.", preferredStyle: .alert)
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler:
                nil)
            optionMenu.addAction(cancelAction)
        // Display the menu
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func notifyButton(_ sender: Any) {
        // Alert
        let optionMenu = UIAlertController(title: "Notification Sent", message: "We have let nearby users know that you are feeling unsafe.", preferredStyle: .alert)
        // Add actions to the menu
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler:
                nil)
            optionMenu.addAction(cancelAction)
        // Display the menu
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
//        locationManager.delegate = self
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
//        let query = PFQuery(className: "User")
//        query.whereKey("location", nearGeoPoint: user?["location"] as! PFGeoPoint)
//
//
//        query.findObjectsInBackground(block: {
//            objects, error in
//            if let proximityArray = objects {
//                for near in proximityArray {
//                    let position = near["location"] as? PFGeoPoint
//
//                    let theirLat = position?.latitude       //this is an optional
//                    let theirLong = position?.longitude     //this is an optional
//                    let theirLocation = PFGeoPoint(latitude: theirLat!, longitude: theirLong!)
//
//                    self.locations.append(theirLocation)
//                    if self.locations.isEmpty {
//
//                    }
//                    else
//                    {
//                        for person in self.locations {
//                            self.displayPin(person)
//                        }
//                    }
//                }
//            };
//    })
    
//    func checkLocationAuthorization() {
//        switch CLLocationManager.authorizationStatus()
//        {
//            case .authorizedWhenInUse:
//                mapView.showsUserLocation = true
//            case .denied: // Show alert telling users how to turn on permissions
//                break
//            case .notDetermined:
//                locationManager.requestWhenInUseAuthorization()
//                mapView.showsUserLocation = true
//            case .restricted: // Show an alert letting them know what’s up
//                break
//            case .authorizedAlways:
//                break
//        }
//    }
    }
}
