//
//  AskAnythingCollectionCell.swift
//  Be Fantastic
//
//  Created by Flywheel on 03/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class AskAnythingCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var askAnythingVideoDetailsButton: UIButton!
    @IBOutlet weak var mVideotittle: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var askAnythingButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbnailImageView.setRadius(radius: 10)
        // Initialization code
    }
}
