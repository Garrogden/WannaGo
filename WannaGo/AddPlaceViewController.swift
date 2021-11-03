//
//  ViewController.swift
//  WannaGo
//
//  Created by Ogden, Garret L on 11/3/21.
//

import UIKit
import MapKit 

class AddPlaceViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    @IBOutlet var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        determineCurrentLocation()
        // Do any additional setup after loading the view.
    }
    
    func determineCurrentLocation () {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.requestWhenInUseAuthorization()
            
            if CLLocationManager.locationServicesEnabled(){
                locationManager.startUpdatingLocation()
            }
        }
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            //currentLocation:CLLocation = locations[0]
            let mUserLocation:CLLocation = locations[0] as CLLocation

                   let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
                   let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

                   mapView.setRegion(mRegion, animated: true)
        }


}

