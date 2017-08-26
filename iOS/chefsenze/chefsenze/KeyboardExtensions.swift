//
//  KeyboardExtensions.swift
//  chefsenze
//
//  Created by César Armando Galván Valles on 8/26/17.
//  Copyright © 2017 César Armando Galván Valles. All rights reserved.
//

import UIKit

extension UIViewController{
    
    //Hide keyboard tapping in the screen
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Dismiss keyboard
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
