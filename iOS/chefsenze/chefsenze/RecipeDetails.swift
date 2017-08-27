//
//  RecipeDetails.swift
//  chefsenze
//
//  Created by César Armando Galván Valles on 8/27/17.
//  Copyright © 2017 César Armando Galván Valles. All rights reserved.
//

import UIKit

class RecipeDetails: UIViewController {

    // Outlets
    @IBOutlet var topBarView: UIView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingredientsTextView: UITextView!
    @IBOutlet weak var cookingMethod: UITextView!
    
    
    // Variables
    var recipe = Recipe()
    var image = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topBarView.layer.backgroundColor = UIColor.AppColors.orangeMain.cgColor
        self.recipeNameLabel.text = recipe.recipeName
        self.recipeNameLabel.textColor = UIColor.white
        self.ingredientsTextView.text = recipe.recipeIngredients
        self.recipeImage.image = image
        for line:String in recipe.recipeMethod {
            self.cookingMethod.text.append(line)
            self.cookingMethod.text.append("\n\n")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getImage(url: URL)
    {
        let session = URLSession(configuration: .default)
        let downloadTask = session.dataTask(with: url)
        {
            (data, response, error) in
            if error != nil {
                print("cant download")
            }
            else {
                if (response as? HTTPURLResponse) != nil {
                    print("got image")
                    if let imgdata = data {
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                self.recipeImage.image = UIImage(data: imgdata)
                            }
                        }
                        //self.recipeImage.image = UIImage(data: imgdata)
                    }
                    else {
                        print("no hay imagen")
                    }
                }
                else {
                    print("no response")
                }
            }
        }
        downloadTask.resume()
        
        
    }
    
    @IBAction func returnToLastView(_ sender: Any) {
        self.dismiss(animated: true) {
            print("Bye")
        }
    }
    

}
