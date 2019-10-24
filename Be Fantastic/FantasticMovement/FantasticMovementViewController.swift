//
//  FantasticMovementViewController.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
// view heigth = 350 , TextView heigth = 52

import UIKit
import SDWebImage
import LetheStretchyHeader


class FantasticMovementViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    
    @IBOutlet weak var heigthConstrainofUpView: NSLayoutConstraint!
    
    @IBOutlet weak var movementTableView: UITableView!
    
   var firstcellArray = ["Screenshot 2019-09-27 at 2.44.28 AM.png","AboutDrFantastic"]
    private var videoListArray = NSMutableArray()
    private var videoTabListPresenter = HomeVideoListPresenter()
    private var paginationEnabled = false
    private var nexPageTokenForVideoDetailsTab = ""
    private var TotalPageCountVideoDetails = 0
    private var heigthofUpperView = Float()
    var pageIdentifier = String()
    var textViewStreched = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movementTableView.delegate = self
        self.movementTableView.dataSource = self
       
        self.customizeDataBasedOnIdentifier()
     
        callJsonFile()
     
    }
    
    func customizeDataBasedOnIdentifier() {
        if pageIdentifier == "AboutDrFantastic"{

           self.bannerImageView.image = UIImage(named: "DrFantasticDetail")
              movementTableView.backgroundView = UIImageView(image: UIImage(named: "BackGroundForDr"))
          
        }else {

         self.bannerImageView.image = UIImage(named: "MoveMentDetails")
        movementTableView.backgroundView = UIImageView(image: UIImage(named: "BackGroundForMov"))
            
        }
    }
    
    func callJsonFile(){
        guard let fileUrl = Bundle.main.url(forResource: "Movementresponse", withExtension: "json") else {
            print("File could not be located at the given url")
            return
        }
        
        do {
            // Get data from file
            let data = try Data(contentsOf: fileUrl)
            
            // Decode data to a Dictionary<String, Any> object
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                print("Could not cast JSON content as a Dictionary<String, Any>")
                return
            }
            print("whole dict is \(dictionary)")
            
            if let mdict = dictionary["items"] as? NSArray {
                print("m dict is \(mdict)")
                self.videoListArray.removeAllObjects()
                
                self.videoListArray.addObjects(from: mdict as! [Any])
                
                DispatchQueue.main.async {
                    self.movementTableView.reloadData()
                    
                }
                
            }
            
            
        } catch {
            // Print error if something went wrong
            print("Error: \(error)")
        }
    }
    
    func strechView(){
//        if pageIdentifier == "AboutDrFantastic"{
//
//         //  self.contentLabel.text = DrFantasticString
//            var frame = self.contentLabel.frame
//            frame.size.height = self.contentLabel.contentSize.height
//            self.contentLabel.frame = frame
//         //   self.heigthConstraintOfTextView.constant =  self.contentLabel.contentSize.height
////            self.upperViewHeigthConstraint.constant =  self.contentLabel.contentSize.height +  self.upperViewHeigthConstraint.constant
//            UIView.animate(withDuration: 0.0, animations: {
//                self.view.layoutIfNeeded()
//                 self.upperViewHeigthConstraint.constant =   self.contentLabel.contentSize.height +   self.upperViewHeigthConstraint.constant
//            })
//        }else {
//
//           // self.contentLabel.text = FantasticMovementString
//            var frame = self.contentLabel.frame
//            frame.size.height = self.contentLabel.contentSize.height
//            self.contentLabel.frame = frame
//          //  self.heigthConstraintOfTextView.constant =  self.contentLabel.contentSize.height
//            self.upperViewHeigthConstraint.constant =   self.contentLabel.contentSize.height +   self.upperViewHeigthConstraint.constant
//            UIView.animate(withDuration: 0, animations: {
//
//                self.view.layoutIfNeeded()
//            })
//        }
        
       
    }
    
    func comeTONormal(){
//       // self.heigthConstraintOfTextView.constant = 52
//        self.upperViewHeigthConstraint.constant = 350
//        UIView.animate(withDuration: 0, animations: {
//            self.view.layoutIfNeeded()
//        })
        
    }
    
    @IBAction func seeMoreButton(_ sender: UIButton) {
        
//        if textViewStreched == true {
//
//            self.strechView()
//            self.seeMoreButtonOutlet.setTitle("See Less", for: .normal)
//             textViewStreched = false
//
//        }else {
//            textViewStreched = true
//            comeTONormal()
//            self.seeMoreButtonOutlet.setTitle("See More", for: .normal)
//
//
//        }
      
       
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

            if scrollView == self.movementTableView {
                if self.movementTableView.contentOffset.y >= 0 && self.movementTableView.contentOffset.y <= 340 {
                    self.heigthConstrainofUpView.constant = 340 - self.movementTableView.contentOffset.y
                       self.bannerImageView.alpha = 1 - (self.movementTableView.contentOffset.y/340)
                } else if self.movementTableView.contentOffset.y > 340 {
                    self.heigthConstrainofUpView.constant = 0
                      self.bannerImageView.alpha = 0.9
                } else if self.movementTableView.contentOffset.y <= 0 {
                    self.heigthConstrainofUpView.constant = 340
                     self.bannerImageView.alpha = 1.0
                }
            }

        }
   
    
    @objc func buttonClickOfCell(sender:UIButton){
        
        if textViewStreched == false {
            textViewStreched = true
            let indexPath = NSIndexPath(row: sender.tag, section: 0)
            self.movementTableView.reloadRows(at: [indexPath as IndexPath], with: .fade)
            
        }else {
            textViewStreched = false
            let indexPath = NSIndexPath(row: sender.tag, section: 0)
            self.movementTableView.reloadRows(at: [indexPath as IndexPath], with: .fade)
        }
        
    }
    
}

extension FantasticMovementViewController: UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoListArray.count + 1
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ExpandableCell", for:indexPath)
                as! ExpandableCell
            if pageIdentifier == "AboutDrFantastic"{
                cell.contentLabel.text = DrFantasticString
            }else {
                cell.contentLabel.text = FantasticMovementString
            }
            cell.seeMoreButton.tag = indexPath.row
            cell.seeMoreButton.addTarget(self, action: #selector(buttonClickOfCell(sender:)), for: .touchUpInside)
            
            if textViewStreched == false {
                cell.seeMoreButton.setTitle("Read More", for: .normal)
            }else {
                 cell.seeMoreButton.setTitle("Read Less", for: .normal)
            }
            
            return cell
            
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "FantasticMovementTableCell", for:indexPath)
                as! FantasticMovementTableCell
            
            if let firstArray = self.videoListArray[indexPath.row - 1] as? [String:Any] {
                
                if let firstDict = firstArray["snippet"] as? [String:Any] {
                    
                    
                    if let titiletext = firstDict["title"] as? String {
                        cell.titleLabel.text = titiletext
                        print("text is \(titiletext)")
                    }
                    
                    
                    if let secoundDict = firstDict["thumbnails"] as? [String:Any] {
                        
                        if let thirdDict = secoundDict["medium"] as? [String:Any]{
                            
                            if let imageUrl = thirdDict["url"] as? String{
                                
                                cell.movementTableCellImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
                            }
                        }
                    }
                }
             }
            
            return cell
        }
      
    
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 0 {
            
        }else{
                if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YouTubeVideoViewController") as? YouTubeVideoViewController{
                        print("video play")
                        if let firstArray = self.videoListArray[indexPath.row] as? [String:Any] {
                            print("first array is \(firstArray)")
            
                            if let mDict = firstArray["id"] as? [String:Any] {
                                if let videoId = mDict["videoId"] as? String {
            
                                     vc.comingVideoID = videoId
                                }
                            }
                        }
            
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(">>>>>>>>>> row heigth method called")
        
        if indexPath.row == 0 {
            if pageIdentifier == "AboutDrFantastic"{
                if textViewStreched == true {
                    return 270
                }else {
                    print("it comes here")
                   return 93
                }
              
                
            }else {
                
                if textViewStreched == true {
                    return 500
                }else {
                    return 93
                }
                
            }
        }else {
            return 122
        }
        
     //  return UITableView.automaticDimension
       
    }
}
