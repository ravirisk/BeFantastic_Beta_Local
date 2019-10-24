//
//  RadioFileTableCell.swift
//  Be Fantastic
//
//  Created by Flywheel on 09/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class RadioFileTableCell: UITableViewCell {

    @IBOutlet weak var detailButtonClick: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumNailImageView: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var playIconImageView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //playIconImageView.roundedImage()
    }
    
    func updatePlayImage(){
      print("update image is called")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension UIImageView {
    func roundedImage() {
        self.layer.cornerRadius = (self.frame.size.width) / 2;
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.clear.cgColor
    }
}
