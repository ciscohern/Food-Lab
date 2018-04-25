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

//structure to decode recipe JSON
struct Recipe: Decodable {
    let id : Int
    let image: String
    let imageType: String
    let likes: Int
    let missedIngredientCount: Int
    let title: String
    let usedIngredientCount: Int
}

class SecondViewController: UIViewController, LoginButtonDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var recipies = [Recipe]()
    var set = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //set collectionview layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 2
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = collectionView.frame.size.width / cellsPerLine - interItemSpacingTotal / cellsPerLine
        layout.itemSize = CGSize(width: width, height: width * 3 / 4)
        
        
        
        //Display the FaceBook Login Buttons
        let loginButton = LoginButton(readPermissions: [ .publicProfile])
        loginButton.delegate = self
        loginButton.frame = CGRect(x:100,y:650,width:200,height:28)
        view.addSubview(loginButton)
        
        
        
        //initial call to preload collectionview
//        ingred = "apples"
//        APITest {
//            self.set = true //necessary to avoid out of index error
//            self.collectionView.reloadData()
//        }
//        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//        }
        
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
    
    var ingredients : String = ""
    var ingred: String = ""
    
    @IBAction func searchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        //Activity indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        ingredients = searchBar.text!
        let splitIngredients = ingredients.components(separatedBy: ",")
        let joined = splitIngredients.joined(separator: ",")
        ingred = joined.components(separatedBy: .whitespaces).joined()
        
        APITest {
            self.set = true
            self.collectionView.reloadData()
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    //Food API JSON
    func APITest(callback: @escaping (() -> Void)) {
        
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "SpoonacularApi")
        let URL:String = "https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/findByIngredients?fillIngredients=false&ingredients=\(ingred)"
        let headers: HTTPHeaders = [
            "X-Mashape-Body":"&limitLicense=false&number=5&ranking=",
            "X-Mashape-Key": retrievedString!,
            "X-Mashape-Host": "spoonacular-recipe-food-nutrition-v1.p.mashape.com",
            "accept": "application/json",
            ]
        print(URL, headers)

        //bounces call to background
        DispatchQueue.global(qos: .userInitiated).async {
            Alamofire.request(URL, headers: headers).responseJSON {(response) in
                debugPrint(response)
                let result = response.data
                do{
                    self.recipies = try JSONDecoder().decode([Recipe].self, from: result!)
                    return 	callback()
                }catch{
                    print("error")
                }
            }
            //brings it back, refreshes UI
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }

        }
        //collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as? RecipeCell
       
        if(self.set == true){
            let imageURL = URL(string: recipies[indexPath.row].image)
            cell?.recipeTitle.text = recipies[indexPath.row].title
            DispatchQueue.main.async {
                cell!.recipieImageView.af_setImage(withURL: imageURL!)
            }
        }
        
        //cell?.backgroundColor = UIColor.cyan
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let desVC = mainStoryboard.instantiateViewController(withIdentifier: "detailViewController") as! DetailViewController
        desVC.rImage = recipies[indexPath.row].image
        desVC.rTitle = recipies[indexPath.row].title
        let s = String(recipies[indexPath.row].id)
        desVC.rId = s
        self.navigationController?.pushViewController(desVC, animated: true)
    }
    
}



