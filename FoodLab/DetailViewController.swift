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
    @IBOutlet weak var instructionsText: UITextView!
    
    var rImage = ""
    var rTitle = ""
    var rId = ""
    
    struct details: Codable {
        let instructions: String?
        
        private enum CodingKeys: String, CodingKey{
            case instructions
        }
    }
    
    
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
    
//    guard let gitUrl = URL(string: "https://api.github.com/users/shashikant86") else { return }
//    URLSession.shared.dataTask(with: gitUrl) { (data, response
//    , error) in
//    guard let data = data else { return }
//    do {
//    let decoder = JSONDecoder()
//    let gitData = try decoder.decode(MyGitHub.self, from: data)
//    print(gitData.name)
//
//    } catch let err {
//    print("Err", err)
//    }
//    }.resume()
    
    
    
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

        DispatchQueue.global(qos: .userInitiated).async {
            Alamofire.request(URL, headers: headers).responseJSON {(response) in
                debugPrint(response)
                let result = response.data
                do{
                    let recipeData = try JSONDecoder().decode(details.self, from: result!)
                    print(recipeData.instructions)
                    self.instructionsText.text = recipeData.instructions
                    //return     callback()
                }catch{
                    print("error")
                }
            }
            //brings it back, refreshes UI
            DispatchQueue.main.async {
                //self.collectionView.reloadData()
            }
        }
    }
//    let recipeData = try decoder.decode(details.self, from: json)
//    print(recipeData.instructions)
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
