//
//  FirstViewController.swift
//  chefsenze
//
//  Created by César Armando Galván Valles on 8/26/17.
//  Copyright © 2017 César Armando Galván Valles. All rights reserved.
//

import UIKit

class SearchIngredientsViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet weak var ingredientTextField: UITextField!
    @IBOutlet weak var ingredientsList: UITableView!
    @IBOutlet weak var recipeButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    
    //Variables
    var cellIngedients : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // Init outlets
        self.backgroundView.backgroundColor = UIColor.AppColors.orangeMain
        
        self.ingredientTextField.delegate = self
        self.ingredientTextField.placeholder = "Write your ingredient"
        self.ingredientTextField.layer.cornerRadius = 12.5
        self.ingredientTextField.layer.borderWidth = 2
        self.ingredientTextField.layer.borderColor = UIColor.AppColors.orangeMain.cgColor
        
        self.ingredientsList.tableFooterView = UIView()
        self.ingredientsList.separatorColor = UIColor.AppColors.orangeMain
        self.ingredientsList.separatorStyle = .singleLine
        
        self.recipeButton.layer.cornerRadius = 12.5
        self.recipeButton.layer.borderWidth = 2
        self.recipeButton.layer.borderColor = UIColor.AppColors.orangeMain.cgColor
        self.recipeButton.layer.backgroundColor = UIColor.AppColors.orangeMain.cgColor
        self.recipeButton.tintColor = UIColor.white

        
        // Init variables
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ingredientTextField {
            let text = ingredientTextField.text!
            if !cellIngedients.contains(text.lowercased()) && text != "" {
                cellIngedients.append(text.lowercased())
                ingredientsList.reloadData()
                let lastrow = cellIngedients.count - 1
                let ip = NSIndexPath(row: lastrow, section: 0)
                ingredientsList.scrollToRow(at: ip as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
            }
            
            ingredientTextField.text = ""
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellIngedients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
        cell.textLabel?.text = cellIngedients[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            self.cellIngedients.remove(at: indexPath.item)
            self.ingredientsList.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    @IBAction func sendQuery(_ sender: Any) {
        if !self.cellIngedients.isEmpty {
            let ingredientsString = self.cellIngedients.joined(separator: ", ")
            print(ingredientsString)
            ChefsenseAPI.getRecipes(ingredients: ingredientsString, completion: { (comp: Bool, list:[Recipe]) in
                if comp {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let recipesView = storyboard.instantiateViewController(withIdentifier: "recipesList") as! RecipeListViewController
                    self.navigationController?.pushViewController(recipesView, animated: true)
                }
            })
        }
    }
}

