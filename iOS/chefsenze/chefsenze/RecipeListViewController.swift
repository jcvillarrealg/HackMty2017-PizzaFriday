//
//  RecipeListViewController.swift
//  chefsenze
//
//  Created by César Armando Galván Valles on 8/27/17.
//  Copyright © 2017 César Armando Galván Valles. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController, UITabBarDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var recipesTableView: UITableView!
    
    
    // Variables
    var recipesList = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init outlets
        self.topBarView.layer.backgroundColor = UIColor.AppColors.orangeMain.cgColor
        self.viewTitle.text = "Recipes found"
        self.viewTitle.textColor = UIColor.white
        
        self.recipesTableView.tableFooterView = UIView()
        self.recipesTableView.separatorColor = UIColor.AppColors.orangeMain
        self.recipesTableView.separatorStyle = .singleLine
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
        /*DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                cell?.recipeThumbnail.downloadedFrom(url: self.recipesList[indexPath.row].recipePhoto)
            }
        }*/
        let session = URLSession(configuration: .default)
        var url = self.recipesList[indexPath.row].recipePhoto
        url = URL(string: "http://" + (url?.absoluteString.substring(from: 2))!)!
        let downloadTask = session.dataTask(with: url!)
        {
            (data, response, error) in
            if error != nil {
                print(error)
                print("cant download")
                print(url!)
            }
            else {
                if (response as? HTTPURLResponse) != nil {
                    print("got image")
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
    }
    
    @IBAction func returnToLastView(_ sender: Any) {
        self.dismiss(animated: true) { 
            print("Bye")
        }
    }
    
}
