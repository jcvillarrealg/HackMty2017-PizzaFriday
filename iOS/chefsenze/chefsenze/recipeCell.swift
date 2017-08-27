//
//  recipeCell.swift
//  chefsenze
//
//  Created by César Armando Galván Valles on 8/27/17.
//  Copyright © 2017 César Armando Galván Valles. All rights reserved.
//

import UIKit

class recipeCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var recipeThumbnail: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
