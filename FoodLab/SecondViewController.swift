//
//  SecondViewController.swift
//  FoodLab
//
//  Created by Francisco Hernanedez on 3/27/18.
//  Copyright © 2018 Francisco Hernanedez. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper
import FBSDKLoginKit
import FacebookLogin

class SecondViewController: UIViewController, LoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Call to the FoodAPI (Currently Causing an error)
        //APITest()
        //Display the FaceBook Login Buttons
        let loginButton = LoginButton(readPermissions: [ .publicProfile])
        loginButton.delegate = self
        loginButton.frame = CGRect(x:100,y:650,width:200,height:28)
        view.addSubview(loginButton)
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("user logged out")
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let svc = storyboard.instantiateViewController(withIdentifier: "ViewController")
        self.present(svc, animated: true, completion: nil)
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("login success")

    }
    //Food API JSON
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
