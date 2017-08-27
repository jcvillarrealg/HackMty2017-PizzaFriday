//
//  Recipe.swift
//  chefsenze
//
//  Created by César Armando Galván Valles on 8/27/17.
//  Copyright © 2017 César Armando Galván Valles. All rights reserved.
//

import Foundation
import SwiftyJSON

class Recipe {
    var recipeName : String
    var recipeUrl : URL!
    var recipePhoto : URL!
    var recipeTime : String
    var recipeMethod : [String]
    var recipeIngredients : String
    
    init() {
        self.recipeName = ""
        self.recipeUrl = URL(string: "")
        self.recipePhoto = URL(string: "")
        self.recipeTime = ""
        self.recipeMethod = [String]()
        self.recipeIngredients = ""
    }
    
    init(_ json:JSON) {
        self.recipeName = json["title"].stringValue
        self.recipeUrl = URL(string: json["url"].stringValue)
        self.recipePhoto = URL(string: json["image_url"].stringValue)
        self.recipeTime = json["time"].stringValue
        let subjson = json["method"].stringValue
        let array = subjson.components(separatedBy: "|")
        self.recipeMethod = [String]()
        for step:String in array {
            self.recipeMethod.append(step)
        }
        self.recipeIngredients = json["ingredients"].stringValue
        self.printRecipe()
    }
    
    func printRecipe() {
        print(self.recipeName)
        print(self.recipeUrl)
        print(self.recipePhoto)
        print(self.recipeTime)
        print(self.recipeMethod)
        print(self.recipeIngredients)
    }
}
