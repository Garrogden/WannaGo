//
//  Place.swift
//  WannaGo
//
//  Created by Ogden, Garret L on 11/3/21.
//
//Comment

import UIKit
import Firebase

struct placeInfo {
    let latitude: Double?
    let longitude: Double?
    let placeName: String?
    let placeCountry: String?
    let placePostalCode: String?
    
    
}

extension placeInfo {
    //Turn a collection from Firestore into an array of appTasks
    static func build(from documents: [QueryDocumentSnapshot]) -> [placeInfo] {
        var places = [placeInfo]()
        for document in documents {
            places.append(placeInfo(
                            placeName: document["Name"] as? String,
                            latitude: document["latitude"] as? Double,
                            longitude: document["longitude"] as? Double,
                            placeCountry: document["country"] as? String,
                            placePostalCode: document["PostalCode"] as? String))
            
        }
        return places
    }
    
    static func buildOne(from document: DocumentSnapshot) -> placeInfo {
       
        return placeInfo(
            placeName: document["Name"] as? String,
            latitude: document["latitude"] as? Double,
            longitude: document["longitude"] as? Double,
            placeCountry: document["country"] as? String,
            placePostalCode: document["PostalCode"] as? String)
        
    }
}
