//
//  ChefsenzeAPI.swift
//  chefsenze
//
//  Created by César Armando Galván Valles on 8/26/17.
//  Copyright © 2017 César Armando Galván Valles. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class ChefsenseAPI {
    
    static let apiurl = "http://10.12.221.251:3000/recipes/"
    
    static func getRecipes(ingredients:String, completion:@escaping (_ didSucceed:Bool, _ recipesList : [Recipe])-> Void){
        let headers:HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json"
        ]
        
        let body : Parameters = [
        "ingredients" : ingredients
        ]
        
        let url = (apiurl + "find").addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print(url)
        Alamofire.request(url, method:.post, parameters:body, headers:headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        let json = JSON(data:data)
                        print(json)
                        var recipes = [Recipe]()
                        for (_,subJson):(String, JSON) in json {
                            recipes.append(Recipe(subJson))
                        }
                        completion(true, recipes)
                    }
                    break
                case .failure:
                    let recipes = [Recipe]()
                    completion(false, recipes)
                    break
                }
        }
    }
}
