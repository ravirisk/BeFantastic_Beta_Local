//
//  VideoDetailTableCell.swift
//  Be Fantastic
//
//  Created by Flywheel on 04/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class VideoDetailTableCell: UITableViewCell {

    @IBOutlet weak var VideoContentView: UILabel!
    @IBOutlet weak var videoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
