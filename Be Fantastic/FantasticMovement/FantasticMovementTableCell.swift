//
//  FantasticMovementTableCell.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class FantasticMovementTableCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var movementTableCellImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
         //  movementTableCellImageView.setRadius(radius: 10)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
