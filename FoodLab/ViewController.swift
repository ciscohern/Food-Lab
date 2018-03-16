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


class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APITest()
        
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
    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

