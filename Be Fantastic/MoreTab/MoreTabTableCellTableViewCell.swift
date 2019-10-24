//
//  MoreTabTableCellTableViewCell.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class MoreTabTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var moreImageView: UIImageView!
    @IBOutlet weak var moretitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

