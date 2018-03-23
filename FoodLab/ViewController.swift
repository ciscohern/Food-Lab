//
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


class ViewController: UIViewController, FBSDKLoginButtonDelegate{
    
    let loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.readPermissions = ["email"]
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //APITest()
        
        view.addSubview(loginButton)
        loginButton.center = view.center
        loginButton.delegate = self
        
        if let token = FBSDKAccessToken.current(){
            fetchProfile()
        }
    }
    
    func fetchProfile(){
        print ("fetch profile")
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email, first_name, last_name, id, gender, picture.type(large)"])
            .start(completionHandler: {
                (connection, result, error) in
                guard
                    let result = result as? NSDictionary,
                    let email = result["email"] as? String,
                    let user_name = result["first_name"] as? String,
                    let user_gender = result["gender"] as? String,
                    let user_id_fb = result["id"] as? String,
                    let picture = result["picture"] as? NSDictionary, let data = picture ["data"] as? NSDictionary,
                    let url = data["url"] as? String
                    else {
                        return };
                print(email);
                print (url);
                
            })
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        print("Login Complete")
        fetchProfile()
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout Complete")
    }
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func APITest(){
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "foodApi")
        
        let headers: HTTPHeaders = [
            "X-Mashape-Key": retrievedString!,
            "X-Mashape-Host": "spoonacular-recipe-food-nutrition-v1.p.mashape.com",
            "accept": "application/json"
        ]
        
        Alamofire.request("https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=apples%2Cflour%2Csugar&limitLicense=false&number=5&ranking=", headers: headers).responseJSON { response in
            debugPrint(response)
            
            
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                print (json)
            case .failure(let error):
                print(error)
            }
        }

    }
    
}

