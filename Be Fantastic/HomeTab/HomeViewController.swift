//
//  HomeViewController.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import MessageUI



class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableViewDownConstarint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraintOfDownView: NSLayoutConstraint!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var bookButtonOutlet: UIButton!
    var containerArray = NSMutableArray()
   
    private var appConfigurePresenter = AppConfigurePresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        bookButtonOutlet.layer.cornerRadius = 10
        bookButtonOutlet.clipsToBounds = true
       
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        appConfigurePresenter.attachView(view: self)
        setBottomView()
      
        self.configureAppView()
        
    }
    
    func setBottomView(){
        bottomConstraintOfDownView.constant = self.tabBarController?.tabBar.frame.height ?? 49.0
      //  tableViewDownConstarint.constant =  self.tabBarController?.tabBar.frame.height ?? 49.0  + 250
    }
    
    func configureAppView(){
          setUpManualy()
//
//        if Reachability.isConnectedToNetwork(){
//
//            self.appConfigurePresenter.jsonFromApi(taskUrl: "", method: "GET", parameters: nil)
//        }else{
//            print("Internet Connection not Available!")
//            CommonClass.sharedCommon.showBasicAlert(on: self, with: BasicAlertTitle, message: InternetConnectionMessage)
//            
//        }
      
    }
    
    @objc func moveToVideoTab(sender:UIButton){
        self.tabBarController?.selectedIndex = 1
    }
    
    @objc func moveToRadionAndPodCast(sender:UIButton){
        if sender.tag == 4 {
            self.tabBarController?.selectedIndex = 3
        }else {
            
            if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RadioShowViewController") as? RadioShowViewController{
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func setUpManualy(){
        
        guard let fileUrl = Bundle.main.url(forResource: "AppConfig", withExtension: "json") else {
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
            
            if let mdict = dictionary["navbarItem"] as? [String:Any] {
                print("m dict is \(mdict)")
                if let mContainerArray = mdict["container"] as? NSArray {
                    
                    
                    self.containerArray.addObjects(from: mContainerArray as! [Any])
                    self.homeTableView.reloadData()
                    print("Container Array is \(containerArray.count)")
                }
            }
            
            
        } catch {
            // Print error if something went wrong
            print("Error: \(error)")
        }
    }
    
    @IBAction func bookButtonAction(_ sender: UIButton) {
        print(">>>>>>>>>>>>>>>>>>> book now")
        
      
            if !MFMailComposeViewController.canSendMail() {
                print("Mail services are not available")
                return
            }
            
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.setToRecipients(["oneqwertysys@gmail.com"])
            composeVC.setSubject("Book a session with Dr. Fantastic")
            composeVC.setMessageBody("I would like to book a session with you and discuss in detail about my situation. Please reach out to me", isHTML: false)
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
       
     
    }
    
    deinit {
        appConfigurePresenter.detachView()
    }
    
}




extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.containerArray.count - 1
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            if indexPath.row == 2 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "FantasticInterviewTableCell", for:indexPath) as! FantasticInterviewTableCell
                cell.askViewAllButton.tag = indexPath.row
                cell.askViewAllButton.addTarget(self, action: #selector(moveToVideoTab(sender:)), for: .touchUpInside)
                cell.cellTitleLabel.font = cell.cellTitleLabel.font.withSize(18)
                cell.cellTitleLabel.textColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                cell.tablecelldelagete = self
                if let containintDict  = self.containerArray[indexPath.row] as? [String:Any]{
                    
                    if let titlelabel = containintDict["containerLabel"] as? String {
                        cell.cellTitleLabel.text = titlelabel
                        cell.callApiFor(data: indexPath.row)
                        // cell.fcollectionView.scrollToItem(at:IndexPath(item: 3, section: 0), at: .right, animated: false)
                        
                    }
                    
                }
                return cell

            }else if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FantasticInterviewTableCell", for:indexPath) as! FantasticInterviewTableCell
                cell.askViewAllButton.tag = indexPath.row
                cell.askViewAllButton.addTarget(self, action: #selector(moveToVideoTab(sender:)), for: .touchUpInside)
                cell.cellTitleLabel.font = cell.cellTitleLabel.font.withSize(18)
                cell.cellTitleLabel.textColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                cell.tablecelldelagete = self
                if let containintDict  = self.containerArray[indexPath.row] as? [String:Any]{
                    
                    if let titlelabel = containintDict["containerLabel"] as? String {
                        cell.cellTitleLabel.text = titlelabel
                        cell.callApiFor(data: indexPath.row)
                       // cell.fcollectionView.scrollToItem(at:IndexPath(item: 3, section: 0), at: .right, animated: false)
                        
                    }
                    
                }
                return cell
              
            }else if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for:indexPath) as! HomeTableCell
                cell.cellTittleLable.font = cell.cellTittleLable.font.withSize(18)
                cell.cellTittleLable.textColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                cell.tablecelldelagete = self
                if let containintDict  = self.containerArray[indexPath.row] as? [String:Any]{
                    
                    if let titlelabel = containintDict["containerLabel"] as? String {
                        cell.cellTittleLable.text = titlelabel
                        cell.callApi(data: indexPath.row)
                        
                    }
                    
                }
                
               return cell
            }else if indexPath.row == 4 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PodCastandRadioTableCell", for:indexPath) as! PodCastandRadioTableCell
                cell.cellImageView.image = UIImage(named: "HomePodcast")
                cell.cellButton.tag = indexPath.row
                cell.cellButton.addTarget(self, action: #selector( moveToRadionAndPodCast(sender:)), for: .touchUpInside)
                return cell
                
            }else if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "AdayInLifeTableCell", for:indexPath) as! AdayInLifeTableCell
                cell.askViewAllButton.tag = indexPath.row
                cell.askViewAllButton.addTarget(self, action: #selector(moveToVideoTab(sender:)), for: .touchUpInside)
                cell.cellTitleLabel.font = cell.cellTitleLabel.font.withSize(18)
                cell.cellTitleLabel.textColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
                cell.tablecelldelagete = self
                if let containintDict  = self.containerArray[indexPath.row] as? [String:Any]{
                    
                    if let titlelabel = containintDict["containerLabel"] as? String {
                        cell.cellTitleLabel.text = titlelabel
                        cell.callApiFor(data: indexPath.row)
                        // cell.fcollectionView.scrollToItem(at:IndexPath(item: 3, section: 0), at: .right, animated: false)
                        
                    }
                    
                }
                return cell
            }else if indexPath.row == 5{
                let cell = tableView.dequeueReusableCell(withIdentifier: "PodCastandRadioTableCell", for:indexPath) as! PodCastandRadioTableCell
                cell.cellImageView.image = UIImage(named: "HomeRadio")
                cell.cellButton.tag = indexPath.row
                cell.cellButton.addTarget(self, action: #selector( moveToRadionAndPodCast(sender:)), for: .touchUpInside)
                
                return cell
            }
 
       let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for:indexPath) as! HomeTableCell
     return cell
    
}
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return CGFloat(RowHeight)
        }else if indexPath.row == 2 {
            return CGFloat(RowHeight)
        }else if indexPath.row == 3 {
            return 255
        }else if indexPath.row == 4{
            return 200
        }else if indexPath.row == 5{
            return 200
        }
        
        
       return 240
    }
    
}

extension HomeViewController:TableCellDelegate {
    func passToVideoDetailsController(videoDict: [String : Any], Index: Int) {
        if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VideoDetailsViewController") as? VideoDetailsViewController{
            print("------------> Video Details Screen Open")
            vc.comingVideoDict = videoDict
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    
    func passToVideoControler(videoId: String,Index:Int) {
       
        if Index == 0 {
            print("send to fantastic movement screen")
            
            if videoId == "DrFantasticAbout"{
                if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FantasticMovementViewController") as? FantasticMovementViewController{
                    print("video play")
                    vc.pageIdentifier = "AboutDrFantastic"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else {
                if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FantasticMovementViewController") as? FantasticMovementViewController{
                    print("video play")
                    vc.pageIdentifier = "Movement"
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }

        }else if Index == 1 {
            
            
          if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YouTubeVideoViewController") as? YouTubeVideoViewController{
             print("video play")
             vc.comingVideoID = videoId
            self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if Index == 2 {
            print("play video")
            if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YouTubeVideoViewController") as? YouTubeVideoViewController{
                print("video play")
                vc.comingVideoID = videoId
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if Index == 4 {
            
         print("send to podcast")
            if videoId == "Radio.png" {
                
                print("send to radio page")
                if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RadioShowViewController") as? RadioShowViewController{
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else {
                self.tabBarController?.selectedIndex = 3
            }
            
            
        }else if Index == 3{
            if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YouTubeVideoViewController") as? YouTubeVideoViewController{
                print("video play")
                vc.comingVideoID = videoId
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
}

extension HomeViewController:AppConfigureView{
    func responseOfAppConfigureApi(dict: NSDictionary, statusCode: Int) {
        if statusCode == 200 {
            
        }else {
            
        }
    }
    
    
}

extension HomeViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
