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
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                cell?.recipeThumbnail.downloadedFrom(url: self.recipesList[indexPath.row].recipePhoto)
            }
        }
        
        return cell!
    }
    
    
}
