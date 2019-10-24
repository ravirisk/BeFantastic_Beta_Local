//
//  HomeCollectionViewCell.swift
//  Be Fantastic
//
//  Created by Ravi on 25/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellVideoDetailButton: UIButton!
    @IBOutlet weak var videoTItle: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    @IBOutlet weak var mCollectionImageView: UIImageView!
    override func awakeFromNib() {
          super.awakeFromNib()
          // mCollectionImageView.setRadius(radius: 10)
          // Initialization code
      }

    deinit {
        
    }

}


