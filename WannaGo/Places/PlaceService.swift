//
//  PlaceService.swift
//  WannaGo
//
//  Created by Ogden, Garret L on 11/3/21.
//


import Firebase

class PlaceService {
    let database = Firestore.firestore()
    func get (collectionID: String, handler: @escaping ([placeInfo]) -> Void) {
        database.collection(collectionID).addSnapshotListener{
            querySnapshot, err in
            if let error = err {
                print(error)
                handler([])
            } else {
                handler(placeInfo.build(from: querySnapshot?.documents ?? []))
            }
        }
    }
    
//    func getOne (collectionID: String, placeName: String, handler: @escaping (placeInfo) -> Void) {
//        database.collection(collectionID).document(placeInfo).addSnapshotListener {DocumentSnapshot, err in
//            if let error = err {
//                print (error)
//            } else {
//                handler(appTask.buildOne(from: DocumentSnapshot!))
//            }
//        }
//    }
    
}
