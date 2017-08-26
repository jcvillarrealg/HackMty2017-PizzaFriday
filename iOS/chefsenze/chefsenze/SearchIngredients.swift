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
    
    
    //Variables
    var cellIngedients : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        ingredientsList.tableFooterView = UIView()
        
        // Init outlets
        self.ingredientTextField.delegate = self
        
        // Init variables
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ingredientTextField {
            if !cellIngedients.contains(ingredientTextField.text!) {
                cellIngedients.append(ingredientTextField.text!)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellIngedients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
        cell.textLabel?.text = cellIngedients[indexPath.row]
        return cell
    }
}

