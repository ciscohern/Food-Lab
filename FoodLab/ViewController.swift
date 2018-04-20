//  ViewController.swift
//  FoodLab
//
//  Created by Francisco Hernanedez on 3/13/18.
//  Copyright © 2018 Francisco Hernanedez. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import FacebookLogin


class ViewController: UIViewController, LoginButtonDelegate , GIDSignInUIDelegate{
    
    var fbLoginSuccess = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginButton = LoginButton(readPermissions: [ .publicProfile])
        loginButton.delegate = self
        loginButton.center = view.center
        loginButton.frame = CGRect(x:100,y:650,width:200,height:28)
        view.addSubview(loginButton)
        
        
    }
    
    func handleFBSessionStateChangeWithNotification(notification: NSNotification) {
        // Switch to MapViewController when logged in
        if ((FBSDKAccessToken.current()) != nil) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("user logged out")
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("login success")
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SecondViewController")
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
    
}
