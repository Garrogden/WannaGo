//
//  ViewController.swift
//  WannaGo
//
//  Created by Ogden, Garret L on 11/3/21.
//

import UIKit
import MapKit
import Firebase
import GoogleSignIn


class AddPlaceViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    @IBOutlet var mapView: MKMapView!
    var mapPlaces = [placeInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongTap))
        mapView.addGestureRecognizer(gestureRecognizer)
        determineCurrentLocation()
        for place in mapPlaces {
            let coordinate = CLLocationCoordinate2D(latitude: place.latitude ?? 55, longitude: place.longitude ?? 66)
            addAnnotation(location: coordinate , title: place.placeName, subtitle: place.administrativeArea)
        }
        // Do any additional setup after loading the view.
    }
    @objc func handleLongTap(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let locationInView = gestureRecognizer.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            let location = CLLocation (latitude: locationOnMap.latitude, longitude: locationOnMap.longitude)
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) {(placemarks, error) in
                if let places = placemarks {
                    for place in places {
                        print("Found placemark \(place.name) in \(place.administrativeArea), \(place.country) at address \(place.postalCode)")
                        self.addAnnotation(location: locationOnMap, title: place.name, subtitle: place.administrativeArea)
                        
                        
                        let db = Firestore.firestore()
                        var placeName: String = "placeName"
                        var placeCountry: String = "placeCountry"
                        var placePostalCode: String = "placePostalCode"
                        let latitude: Double = locationOnMap.latitude
                        let longitude: Double = locationOnMap.longitude
                        var administrativeArea: String = ""
                        
                        if let name = place.name {
                                   placeName = name
                               }
                        if let country = place.country {
                                   placeCountry = country
                               }
                        if let postal = place.postalCode {
                                   placePostalCode = postal
                               }
                        if let area = place.administrativeArea {
                            administrativeArea = area
                        }
                                                
                        var ref: DocumentReference? = nil
                                
                                var collection = ""
                                if let user = GIDSignIn.sharedInstance.currentUser {
                                    collection = user.userID!
                                }
                                
                                ref = db.collection(collection).addDocument(data: [
                                    "placeName": placeName,
                                    "placeCountry": placeCountry,
                                    "placePostalCode": placePostalCode,
                                    "longitude": longitude,
                                    "latitude": latitude,
                                    "administrativeArea": administrativeArea
                                ]) { err in
                                    if let err = err {
                                        print("Error writing document: \(err)")
                                    } else {
                                        print("Document added with ID \(ref!.documentID )")
                                    }
                                    
                                }
                    }
                }
            }
          
        }
    }
    
    func addAnnotation(location: CLLocationCoordinate2D, title: String? ,subtitle: String?) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title ?? ""
        annotation.subtitle = subtitle ?? ""
        self.mapView.addAnnotation(annotation)
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

