//
//  CustomView.swift
//  Be Fantastic
//
//  Created by Ravi on 29/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addBehavior()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func addBehavior() {
//        self.layer.cornerRadius = 10 ?? self.frame.width / 2;
//        self.layer.masksToBounds = true;
    }
}
