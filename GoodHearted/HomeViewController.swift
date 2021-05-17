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

    
    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    var user = PFUser.current()
   
    var locations = [PFGeoPoint]()
    var listofUsers = [PFUser]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        pin.title = username
        print(username)
        mapView.addAnnotation(pin)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        //let userGeoPoint = (user?["location"]) as! PFGeoPoint
        let query = PFUser.query()
        //query?.whereKey("Location", nearGeoPoint:userGeoPoint)
        query?.findObjectsInBackground(block: {
            objects, error in
            if let listofUsers = objects {
                for object in listofUsers {
                    if (object["username"] as! String != self.user?.username)
                    {
                        let location = object["Location"] as! PFGeoPoint
                        print(location)
                        print("Getting location!")
                        self.displayPin(location, object["username"] as! String)
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
