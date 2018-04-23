//
//  DetailViewController.swift
//  FoodLab
//
//  Created by Joe Antongiovanni on 4/17/18.
//  Copyright © 2018 Francisco Hernanedez. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var rImage = ""
    var rTitle = ""
    //var rId : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let myString = String(rId)

        let URLimage = URL(string: rImage)
        self.recipeImage.af_setImage(withURL: URLimage!)
        self.titleLabel.text! = rTitle
        //self.idLabel.text! = myString
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
