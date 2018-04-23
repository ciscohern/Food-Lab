//
//  DetailViewController.swift
//  FoodLab
//
//  Created by Joe Antongiovanni on 4/17/18.
//  Copyright © 2018 Francisco Hernanedez. All rights reserved.
//

import UIKit
import AlamofireImage
import SwiftKeychainWrapper
import Alamofire
import SwiftyJSON
import Foundation


class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var rImage = ""
    var rTitle = ""
    var rId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecipeInfo()

        let URLimage = URL(string: rImage)
        self.recipeImage.af_setImage(withURL: URLimage!)
        self.titleLabel.text! = rTitle
        self.idLabel.text! = rId
        //self.recipeImage.image = rImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        performSegue(withIdentifier: "detailReturnMain", sender: (Any).self)

    }
    
    func RecipeInfo(){
       // let RecipeID = rId

        
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "SpoonacularApi")
        let URL:String = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/\(rId)/information"
        
        let headers: HTTPHeaders=[
            "X-Mashape-Body":"/information?includeNutrition=false",
            "X-Mashape-Key":retrievedString!,
            "X-Mashape-Host": "spoonacular-recipe-food-nutrition-v1.p.mashape.com",
            "accept": "application/json",
            ]
        print(URL, headers)
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
