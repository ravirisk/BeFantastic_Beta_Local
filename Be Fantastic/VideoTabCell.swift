//
//  VideoTabCell.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class VideoTabCell: UICollectionViewCell {
    
    @IBOutlet weak var videoTitleButton: UILabel!
    @IBOutlet weak var videoDetailsButton: UIButton!
    @IBOutlet weak var videoPlayButton: UIButton!
    @IBOutlet weak var mVideoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        print("method call")
      // mVideoImageView.setRadius(radius: 10)
        // Initialization code
    }

}
extension UIView {
    func setRadius(radius: CGFloat? = nil) {
        self.layer.cornerRadius = radius ?? self.frame.width / 2;
        self.layer.masksToBounds = true;
    }
}
