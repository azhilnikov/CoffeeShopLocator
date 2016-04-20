//
//  ShopCell.swift
//  CoffeeShopLocator
//
//  Created by Alexey on 20/04/2016.
//  Copyright © 2016 Alexey Zhilnikov. All rights reserved.
//

import UIKit

class ShopCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
