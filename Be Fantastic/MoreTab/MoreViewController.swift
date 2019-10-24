//
//  MoreViewController.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {
    
    @IBOutlet weak var mTableView: UITableView!
    let optionArray = ["Rate the App","Share the love","Settings"]
    let imageArray =  ["RateUs","Share","Settings"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mTableView.dataSource = self
        self.mTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    

}

extension MoreViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTabTableCellTableViewCell", for:indexPath) as! MoreTabTableCellTableViewCell
        cell.moretitleLabel.text = optionArray[indexPath.row]
        cell.moreImageView.image = UIImage(named: imageArray[indexPath.row])
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(red: 148/255, green: 141/255, blue:94/255, alpha: 1.0)
        cell.selectedBackgroundView = selectedView

      
            return cell
        }
      
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
        if indexPath.row == 1 {
            UIGraphicsBeginImageContext(view.frame.size)
            view.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let textToShare = "Check out Be Fantastic app"
            
            if let myWebsite = URL(string: "http://itunes.apple.com/app/\(APPId)") {//Enter link to your app here
                let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "Fantastic Logo")] as [Any]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                
                //Excluded Activities
                activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                //
                
               
                self.present(activityVC, animated: true, completion: nil)
                 }
            
        } else if indexPath.row == 0 {
          
            let urlStr = "https://itunes.apple.com/app/id\(APPId)?action=write-review" // (Option 2) Open App Review Page
            
            guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url) // openURL(_:) is deprecated from iOS 10.
            }
        }else if indexPath.row == 2 {
            if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController {
                print("video play")
               
                self.navigationController?.pushViewController(vc, animated: true)
            }
          }
     
        
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59;//Choose your custom row height
    }
    
}
