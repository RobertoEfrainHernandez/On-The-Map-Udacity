//
//  MapTableViewCell.swift
//  On-The-Map-Udacity
//
//  Created by Roberto Hernandez on 1/21/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

// Mark: -- Map Table View Cell
/***************************************************************/

class MapTableViewCell: UITableViewCell {
    
    // Mark: - Outlets
    /***************************************************************/
    @IBOutlet weak var mapIcon: UIImageView!
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentURLLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
