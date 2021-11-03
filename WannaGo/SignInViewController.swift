//
//  SignInViewController.swift
//  WannaGo
//
//  Created by Ogden, Garret L on 11/3/21.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController {
    let signInCofig = GIDConfiguration.init(clientID: "5082897763-ubg1j6dsb8ucgiie357fkvkk1p71emi8.apps.googleusercontent.com")
    
    @IBOutlet weak var signInButton: GIDConfiguration!
    @IBAction func signIn(_ sender: Any){
        print("Signed in!")
        GIDSignIn.sharedInstance.signIn(with: signInCofig , presenting:self) {
            user, error in
            guard error == nil else {return}
            guard let user = user else {return}
            print(user.profile?.email)
            print(user.userID)
            
            self.performSegue(withIdentifier: "viewPlaces", sender: nil)
        }
        
    }
    @IBAction func signOut (_ sender: Any){
        print("Signed out!")
        GIDSignIn.sharedInstance.signOut()
        
    }
    
    //View Lifecycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = GIDSignIn.sharedInstance.currentUser{
            self.performSegue(withIdentifier: "viewPlaces", sender: nil)
        }
    }
}
