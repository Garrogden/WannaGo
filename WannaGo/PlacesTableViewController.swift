//
//  PlacesTableViewController.swift
//  WannaGo
//
//  Created by Ogden, Garret L on 11/3/21.
//

import UIKit
import Firebase
import GoogleSignIn

class PlacesTableViewController: UITableViewController {
    private var service: PlaceService?
    private var allplaces = [placeInfo]() {
           didSet {
               DispatchQueue.main.async {
                self.places = self.allplaces
               }
           }
       }

    var places = [placeInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func loadData() {
        service = PlaceService()
        var collection = ""
        if let user = GIDSignIn.sharedInstance.currentUser {
            collection = user.userID!
        }
        service?.get(collectionID: collection){
            places in
            self.allplaces = places
            
        }
    }
    
    //Event Lifecycle Functions
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func viewDidLoad() {
            //Load our data from Firestore
            loadData()
        }
    
    // MARK: Table View Controller required methods (2 of them)
            override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return places.count
            }
    
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            
        cell.textLabel?.text = places[indexPath.row].placeName
        cell.detailTextLabel?.text = places[indexPath.row].administrativeArea
            return cell
            
                    
                }
}
