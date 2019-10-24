//
//  HomeTabbarController.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class HomeTabbarController: UITabBarController {
    
  let arrayOfImageNameForSelectedState = ["SeHome","SeVideos","SeeQuotes","SePodcast","SeMore"]
    
  let arrayOfImageNameForUnselectedState = ["UnHome","UnVideos","UnQuotes","UnPodcast","UnMore"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]

                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }

        
        
        let selectedColor   = UIColor(red: 245.0/255.0, green: 193.0/255.0, blue: 66.0/255.0, alpha: 1.0)
        let unselectedColor = UIColor(red: 254.0/255.0, green: 254.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
     //   if let count = self.tabBar.items?.count {
//            for i in 0...(count-1) {
//                let imageNameForSelectedState   = arrayOfImageNameForSelectedState[i]
//                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
//
//                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
//                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
//            }
//        }
        
    

    }
    
    
    
    
}
//extension UIImage {
//    
//    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
//        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        color.setFill()
//        UIRectFill(rect)
//        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//        return image
//    }
//}

