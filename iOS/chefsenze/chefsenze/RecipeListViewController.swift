//
//  RecipeListViewController.swift
//  chefsenze
//
//  Created by César Armando Galván Valles on 8/27/17.
//  Copyright © 2017 César Armando Galván Valles. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Outlets
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var recipesTableView: UITableView!
    
    
    // Variables
    var recipesList = [Recipe]()
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init outlets
        self.topBarView.layer.backgroundColor = UIColor.AppColors.orangeMain.cgColor
        self.viewTitle.text = "Recipes found"
        self.viewTitle.textColor = UIColor.white
        
        self.recipesTableView.tableFooterView = UIView()
        self.recipesTableView.separatorColor = UIColor.AppColors.orangeMain
        self.recipesTableView.separatorStyle = .singleLine
        self.recipesTableView.allowsSelection = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesList.count
    }
    
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? recipeCell
        
        if cell == nil {
            tableView.register(UINib.init(nibName: "recipeCell", bundle: nil), forCellReuseIdentifier: "recipeCell")
            cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell") as? recipeCell
        }
        
        cell?.recipeName.text = recipesList[indexPath.row].recipeName
        cell?.recipeTime.text = recipesList[indexPath.row].recipeTime
        
        let session = URLSession(configuration: .default)
        var url = self.recipesList[indexPath.row].recipePhoto
        url = URL(string: "http://" + (url?.absoluteString.substring(from: 2))!)!
        let downloadTask = session.dataTask(with: url!)
        {
            (data, response, error) in
            if error != nil {
                print("cant download")
                
            }
            else {
                if (response as? HTTPURLResponse) != nil {
                    if let imgdata = data {
                        DispatchQueue.global(qos: .userInitiated).async {
                            DispatchQueue.main.async {
                                cell?.recipeThumbnail.image = UIImage(data: imgdata)
                            }
                        }
                        cell?.recipeThumbnail.image = UIImage(data: imgdata)
                        
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
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hola")
        self.recipesList[indexPath.row].printRecipe()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let recipeDetails = storyboard.instantiateViewController(withIdentifier: "recipeDetails") as! RecipeDetails
        recipeDetails.recipe = recipesList[indexPath.row]
        //recipeDetails.image = images[indexPath.row]
        //recipeDetails.recipeImage.image = images[indexPath.row]
        let ip = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: ip!) as! recipeCell
        
        //recipeDetails.recipeImage.image = currentCell.recipeThumbnail.image
        self.present(recipeDetails, animated: true, completion: nil)
    }
    
    @IBAction func returnToLastView(_ sender: Any) {
        self.dismiss(animated: true) { 
            print("Bye")
        }
    }
    
}
