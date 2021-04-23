//
//  HomeViewController.swift
//  GoodHearted
//
//  Created by Le Thuy on 4/21/21.
//
import MapKit
import UIKit

class HomeViewController: UIViewController {

    
    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        }
        else
        {
            // Show alert to let user know they have to turn location on
        }
        
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus()
        {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
            case .denied: // Show alert telling users how to turn on permissions
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                mapView.showsUserLocation = true
            case .restricted: // Show an alert letting them know what’s up
                break
            case .authorizedAlways:
                break
        }
    }
}