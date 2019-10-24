//
//  RadioShowViewController.swift
//  Be Fantastic
//
//  Created by Ravi on 09/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import iOSAudioPlayer
 //let kTestTimeInterval = 20.0
 

class RadioShowViewController: UIViewController {
    
    let radioShowArray = [
[
    "title":"Believe in yourself",
    "Link":"http://healthylifenet.mainstreamnetwork.com/media/DF091719.mp3",
    "Image":"Image1",
    "Date" :"10/15/2019"
    
        ],[
        "title":"DF 0917",
        "Link":"http://healthylifenet.mainstreamnetwork.com/media/DF091719.mp3",
        "Image":"Image2",
        "Date" :"09/17/2019"
            ],
[
    "title":"The Art of Positivity",
    "Link":"http://healthylifenet.mainstreamnetwork.com/media/DF082019.mp3",
    "Image":"Image2",
    "Date" :"08/20/2019"
        ],
        
[
    "title":"Moses Edward - The Men's Guide to Staying Married",
    "Link":"http://healthylifenet.mainstreamnetwork.com/media/DF071619.mp3",
    "Image":"Image3",
    "Date" :"07/16/2019"
    
        ],[
            "title":"Dr. Fantastic and Friends",
            "Link":"http://healthylifenet.mainstreamnetwork.com/media/DF061819.mp3",
            "Image":"Image1",
            "Date" :"06/18/2019"
            
        ],[
            "title":"To Be Fantastic",
            "Link":"http://healthylifenet.mainstreamnetwork.com/media/DF052119.mp3",
            "Image":"Image2",
            "Date" :"05/21/2019"
            
        ],
    ]

    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var playViewBottomConstrain: NSLayoutConstraint!
    @IBOutlet weak var playButtonViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var playViewSongNameLabel: UILabel!
    @IBOutlet weak var playViewImageView: UIImageView!
    @IBOutlet weak var upViewHiegthConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var radioTableView: UITableView!
    var selectedIndexPath = -1
    var senderTag = -2
    var sliderTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.radioTableView.dataSource = self
        self.radioTableView.delegate = self
        let backgroundImage = UIImage(named: "RadioTableViewBackground")
        let imageView = UIImageView(image: backgroundImage)
        self.radioTableView.backgroundView = imageView
        self.radioTableView.backgroundView = imageView
        playViewBottomConstrain.constant = self.tabBarController?.tabBar.frame.height ?? 49.0
       playButtonViewConstraint.constant = 0
        tableViewBottomConstraint.constant =  self.tabBarController?.tabBar.frame.height ?? 49.0
       
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        if selectedIndexPath == -1 {
            self.navigationController?.popViewController(animated: true)
        }else {
            self.performradioAction()
           
        }
       
       
    }
    
    func updateView(link:String, path:Int){
        self.playButtonViewConstraint.constant = 65
         tableViewBottomConstraint.constant =  -(self.tabBarController?.tabBar.frame.height ?? 49.0 + 65)
          if let radiodict = self.radioShowArray[path] as? [String:Any]{
        if let title = radiodict["title"] as? String {
           self.playViewSongNameLabel.text = title
        }
        
         if let imageName = radiodict["Image"] as? String {
            self.playViewImageView.image = UIImage(named: imageName)
         }
        }
                
    
        let dictionary: Dictionary <String, AnyObject> = SpringboardData.springboardDictionary(title: "Demo Album", artist: "Demo Artist", duration: Int (300.0), listScreenTitle: "Demo List Screen Title", imagePath: Bundle.main.path(forResource: "", ofType: "png")!)
        TPGAudioPlayer.sharedInstance().playPauseMediaFile(audioUrl: URL(string: link)! as NSURL, springboardInfo: dictionary, startTime: 0.0, completion: {(_ , stopTime) -> () in
            self.updatePlayButton()
            self.setupSlider()
            
            
        } )
    }
    
    @IBAction func playorPauseAction(_ sender: UIButton) {
        
        if let radiodict = self.radioShowArray[selectedIndexPath] as? [String:Any]{
            
            if let audiolink = radiodict["Link"] as? String {
                let dictionary: Dictionary <String, AnyObject> = SpringboardData.springboardDictionary(title: "Demo Album", artist: "Demo Artist", duration: Int (300.0), listScreenTitle: "Demo List Screen Title", imagePath: Bundle.main.path(forResource: "", ofType: "png")!)
                
                
                TPGAudioPlayer.sharedInstance().playPauseMediaFile(audioUrl: URL(string: audiolink)! as NSURL, springboardInfo: dictionary, startTime: 0.0, completion: {(_ , stopTime) -> () in
                    
                    self.updatePlayButton()
                } )
            }
        }
        self.radioTableView.reloadData()
       
    }
    func updatePlayButton() {
        let playPauseImage = (TPGAudioPlayer.sharedInstance().isPlaying ? UIImage(named: "paused") : UIImage(named: "played"))
        
        self.playButtonOutlet.setImage(playPauseImage, for: UIControl.State())
    }
    
    func setupSlider() {
//        self.sliderOutlet.maximumValue = Float( TPGAudioPlayer.sharedInstance().durationInSeconds )
//        self.sliderOutlet.minimumValue = 0.0
        
        if let _ = self.sliderTimer {
            self.sliderTimer?.invalidate()
        }

//
        self.setupTotalTimeLabel()
    }
    
    @objc func sliderTimerTriggered() {
        let playerCurrentTime = TPGAudioPlayer.sharedInstance().currentTimeInSeconds
        
      //  self.sliderOutlet.value = Float( playerCurrentTime )
        
        self.updateCurrentTimeLabel(Float( playerCurrentTime ))
    }
    
    func updateCurrentTimeLabel(_ currentTimeInSeconds: Float) {
        if currentTimeInSeconds.isNaN || currentTimeInSeconds.isInfinite {
            return
        }
        
        currentTimeLabel.text = timeLabelString( Int( currentTimeInSeconds ) )
    }
    
    func setupTotalTimeLabel() {
        let duration = TPGAudioPlayer.sharedInstance().durationInSeconds
        
        if duration.isNaN || duration.isInfinite {
            return
        }
        
        totalTimeLabel.text = timeLabelString( Int (duration) )
    }
    
    func timeLabelString(_ duration: Int) -> String {
        let currentMinutes = Int(duration) / 60
        let currentSeconds = Int(duration) % 60
        
        return currentSeconds < 10 ? "\(currentMinutes):0\(currentSeconds)" : "\(currentMinutes):\(currentSeconds)"
    }
    
    @objc func buttonClickOfCell(sender:UIButton){
        
        if let radiodict = self.radioShowArray[sender.tag] as? [String:Any]{
            selectedIndexPath = sender.tag
            senderTag = sender.tag
            if let audiolink = radiodict["Link"] as? String {
                self.updateView(link: audiolink, path: sender.tag)
               // self.radioTableView.reloadData()
                
            }
        }
 
        
    }
    
    
    @objc func detailButtonClick(sender:UIButton) {
        if let radiodict = self.radioShowArray[sender.tag] as? [String:String]{
        
            if let audiolink = radiodict["Link"] {
                //  self.updateView(link: audiolink, path: indexPath.row)
                if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RadioPlayerViewController") as? RadioPlayerViewController{
                    print("------------> Video Details Screen Open")
                    //vc.kTestLink = audiolink
                    vc.comingDict = radiodict
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
            }
        }
        
    }
    
    @IBAction func seeMoreButton(_ sender: UIButton) {
        if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SeeMoreViewController") as? SeeMoreViewController{
            vc.contentString = RadioShowString
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == self.radioTableView {
//            if self.radioTableView.contentOffset.y >= 0 && self.radioTableView.contentOffset.y <= 350 {
//                self.upViewHiegthConstraint.constant = 350 - self.radioTableView.contentOffset.y
//
//            } else if self.radioTableView.contentOffset.y > 350 {
//                self.upViewHiegthConstraint.constant = 0
//
//            } else if self.radioTableView.contentOffset.y <= 0 {
//                self.upViewHiegthConstraint.constant = 350
//             
//            }
//        }
    }
    
    
 func performradioAction() {
    
        if let radiodict = self.radioShowArray[selectedIndexPath] as? [String:Any]{
         
            if let link = radiodict["Link"] as? String {
                let dictionary: Dictionary <String, AnyObject> = SpringboardData.springboardDictionary(title: "Demo Album", artist: "Demo Artist", duration: Int (300.0), listScreenTitle: "Demo List Screen Title", imagePath: Bundle.main.path(forResource: "", ofType: "png")!)
            
                TPGAudioPlayer.sharedInstance().playPauseMediaFile(audioUrl: URL(string: link)! as NSURL, springboardInfo: dictionary, startTime: 0.0, completion: {(_ , stopTime) -> () in
                     self.navigationController?.popViewController(animated: true)
                } )

                
            }
        }
      
        
    }
    
}

extension RadioShowViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.radioShowArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadioFileTableCell", for:indexPath) as! RadioFileTableCell
        
        if let radiodict = self.radioShowArray[indexPath.row] as? [String:Any]{
            if let title = radiodict["title"] as? String {
                cell.titlelabel.text = title
            }
            
            if let imageName = radiodict["Image"] as? String {
               cell.thumNailImageView.image = UIImage(named: imageName)
            }
            
            if let date = radiodict["Date"] as? String {
                cell.dateLabel.text = date
            }
            
            
            cell.playButton.tag = indexPath.row
            cell.playButton.addTarget(self, action: #selector(buttonClickOfCell(sender:)), for: .touchUpInside)
            cell.detailButtonClick.tag = indexPath.row
            cell.detailButtonClick.addTarget(self, action: #selector(detailButtonClick(sender:)), for: .touchUpInside)
              cell.playButton.setImage(UIImage(named: "played"), for: UIControl.State())

        }
        
        return cell
        
        
    }
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("deselect method called \(indexPath.row)")
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        self.radioTableView.reloadRows(at: [indexPath], with: .none)
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62//Choose your custom row height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 81
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "CustomHeaderCell") as! CustomHeaderCell
        return headerCell
       
    }
    
}

