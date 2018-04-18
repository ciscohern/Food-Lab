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
    
    @IBOutlet weak var ingredientText: UITextField!
    var ingredients : String = ""
    var ingred: String = ""
    @IBAction func ingredientButton(_ sender: UIButton) {
      
        ingredients = ingredientText.text!
        let splitIngredients = ingredients.components(separatedBy: ",")
        let joined = splitIngredients.joined(separator: ",")
        ingred = joined.components(separatedBy: .whitespaces).joined()
        IngredientSearch()
        
    }
    
    func RecipeInfo(){
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "SpoonacularApi")
         let URL:String = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/\(570476)"
        
        let headers: HTTPHeaders=[
            "X-Mashape-Body":"/information?includeNutrition=false",
            "X-Mashape-Key":retrievedString!,
            "accept": "application/json",
        ]
        Alamofire.request(URL, headers: headers).responseJSON { response in
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
    
    
    
    //Food API JSON
    func IngredientSearch(){
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "SpoonacularApi")
        
        let URL:String = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=\(ingred)"
        
        let headers: HTTPHeaders = [
            "X-Mashape-Body":"&limitLicense=false&number=6&ranking=",
            "X-Mashape-Key": retrievedString!,
            "X-Mashape-Host": "spoonacular-recipe-food-nutrition-v1.p.mashape.com",
            "accept": "application/json",
        ]
        
        Alamofire.request(URL, headers: headers).responseJSON { response in
            debugPrint(response)
            print("------------------------------------------------")
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                
                var titleString = [String]()
                for i in 0...4{
                    let title:JSON = json[i]["title"]
                    titleString.append(title.rawString([:])!)
                }
                print(titleString)
             

               // print (json)
            case .failure(let error):
                print(error)
            }

        }
    }
    
}
