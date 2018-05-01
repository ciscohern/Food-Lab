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
    @IBOutlet weak var servingsLabel: UILabel!
    @IBOutlet weak var readyInLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var segmentCont: UISegmentedControl!
    
    @IBOutlet weak var instructionsText: UITextView!
    
    @IBOutlet weak var vegetarianLabel: UILabel!
    @IBOutlet weak var veganLabel: UILabel!
    @IBOutlet weak var glutenLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    var rImage = ""
    var rTitle = ""
    var rId = ""
    
    
    struct details: Codable {
        let aggregateLikes: Int
        let instructions: String?
        let servings:Int
        let spoonacularScore: Int
        let readyInMinutes: Int
        let vegan: Int
        let vegetarian: Int
        let weightWatcherSmartPoints: Int
        let glutenFree: Int
        let healthScore: Int
        
        private enum CodingKeys: String, CodingKey{
            case aggregateLikes
            case instructions
            case servings
            case spoonacularScore
            case readyInMinutes
            case vegan
            case vegetarian
            case weightWatcherSmartPoints
            case glutenFree
            case healthScore
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .background).async {
            self.RecipeInfo()
        }

        DispatchQueue.main.async {

            let URLimage = URL(string: self.rImage)
        self.recipeImage.af_setImage(withURL: URLimage!)
            self.titleLabel.text! = self.rTitle
            self.idLabel.text! = "ID: " + self.rId
        
        self.segmentCont.selectedSegmentIndex = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    @IBAction func didTapBackButton(_ sender: Any) {
//        performSegue(withIdentifier: "detailReturnMain", sender: (Any).self)
//
//    }
//
    
    func RecipeInfo(){
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "SpoonacularApi")
        
        let URL:String = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/\(rId)/information"
        
        let headers: HTTPHeaders=[
            "X-Mashape-Body":"/information?includeNutrition=false",
            "X-Mashape-Key":retrievedString!,
            "X-Mashape-Host": "spoonacular-recipe-food-nutrition-v1.p.mashape.com",
            "accept": "application/json",
            ]
        print(URL, headers)

        DispatchQueue.global(qos: .default).async {
            Alamofire.request(URL, headers: headers).responseJSON {(response) in
                debugPrint(response)
                let result = response.data
                do{
                    let recipeData = try JSONDecoder().decode(details.self, from: result!)
                    //print(recipeData.instructions)
                    //self.instructionsText.text = recipeData.instructions
                    DispatchQueue.main.async {
                        self.instructionsText.text = recipeData.instructions!
                        self.servingsLabel.text = "Servings: " + String(recipeData.servings)
                        self.readyInLabel.text = "Ready in: " + String(recipeData.readyInMinutes) + " minutes"
                        self.likesLabel.text = String(recipeData.aggregateLikes) + " Likes"
                        self.scoreLabel.text = "Score: " + String(recipeData.spoonacularScore)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }

    
    @IBAction func segmentTap(_ sender: Any) {
        let getIndex = segmentCont.selectedSegmentIndex
        
        print(getIndex)

        switch (getIndex) {
        case 0:
            self.instructionsText.isHidden = false
            self.vegetarianLabel.isHidden = true
            self.veganLabel.isHidden = true
            self.glutenLabel.isHidden = true
            self.healthLabel.isHidden = true
            self.weightLabel.isHidden = true
        case 1:
            self.instructionsText.isHidden = true
            self.vegetarianLabel.isHidden = false
            self.veganLabel.isHidden = false
            self.glutenLabel.isHidden = false
            self.healthLabel.isHidden = false
            self.weightLabel.isHidden = false
        case 2:
            self.instructionsText.isHidden = true
        default:
            print("nothing Selected")
        }
    }
    
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
