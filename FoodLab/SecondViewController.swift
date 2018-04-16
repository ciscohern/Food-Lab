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
import AlamofireImage
import SwiftyJSON
import SwiftKeychainWrapper
import FBSDKLoginKit
import FacebookLogin


struct Recipe: Decodable {
    let id : Int
    let image: String
    let imageType: String
    let likes: Int
    let missedIngredientCount: Int
    let title: String
    let usedIngredientCount: Int
}

class SecondViewController: UIViewController, LoginButtonDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var recipies = [Recipe]()
    var set = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Call to the FoodAPI (Currently Causing an error)
        
        //Display the FaceBook Login Buttons
        let loginButton = LoginButton(readPermissions: [ .publicProfile])
        loginButton.delegate = self
        loginButton.frame = CGRect(x:100,y:650,width:200,height:28)
        view.addSubview(loginButton)
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
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
        APITest()
        //self.set = true
        collectionView.reloadData()
    }
    
    
    //Food API JSON
    func APITest(){
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "SpoonacularApi")
        
        let URL:String = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=\(ingred)"
        let headers: HTTPHeaders = [
            "X-Mashape-Body":"&limitLicense=false&number=5&ranking=",
            "X-Mashape-Key": retrievedString!,
            "X-Mashape-Host": "spoonacular-recipe-food-nutrition-v1.p.mashape.com",
            "accept": "application/json",
            ]
        
//                Alamofire.request(URL, headers: headers).responseJSON { response in
//                    //debugPrint(response)
//
//                    switch response.result{
//                    case .success(let value):
//                        let json = JSON(value)
//                        print (json)
//                        self.recipies = try JSONDecoder().decode([Recipe].self, from: json)
//                        for recipe in self.recipies{
//                            print(recipe.title)
//                        }
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
        

        Alamofire.request(URL, headers: headers).responseJSON {(response) in

            //debugPrint(response)
            let result = response.data
            //debugPrint(result)
            do{
                self.recipies = try JSONDecoder().decode([Recipe].self, from: result!)
                for recipe in self.recipies{
                    print(recipe.title, " : ", recipe.id)
                }
            }catch{
                print("error")
            }
        }
        //collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as? RecipeCell
        
//        let dictionary = recipies[indexPath.row] as [String:Any]
//        if let imagePath = dictionary["image"] as? String {
            //cell!.recipieImageView = imagePath
        
        if(self.set == true){
//        let imageURL = URL(string: recipies[indexPath.row].image)
//        cell?.recipieImageView.af_setImage(withURL: imageURL!)
            cell?.recipeTitle.text = recipies[indexPath.row].title
        }
//        for recipe in self.recipies{
//            let imageURL = URL(string: recipe.image)!
//            cell?.recipieImageView.af_setImage(withURL: imageURL)
//            print(imageURL)
//        }
        
        cell?.backgroundColor = UIColor.cyan
        return cell!
    }
    
}
