//
//  ExpandableCell.swift
//  Be Fantastic
//
//  Created by Flywheel on 22/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class ExpandableCell: UITableViewCell {

   
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
