//
//  ingredientCell.swift
//  chefsenze
//
//  Created by César Armando Galván Valles on 8/26/17.
//  Copyright © 2017 César Armando Galván Valles. All rights reserved.
//

import UIKit

class ingredientCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var ingedientName: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
