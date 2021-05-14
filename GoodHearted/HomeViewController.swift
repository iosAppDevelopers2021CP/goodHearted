//
//  HomeViewController.swift
//  GoodHearted
//
//  Created by Le Thuy on 4/21/21.
//
import MapKit
import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
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
