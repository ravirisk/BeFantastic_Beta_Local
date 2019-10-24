//
//  VideoDetailsViewController.swift
//  Be Fantastic
//
//  Created by Flywheel on 04/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit


class VideoDetailsViewController: UIViewController {
    
    @IBOutlet weak var videoDetailsTableView: UITableView!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailViewHeigthConstraint: NSLayoutConstraint!
    @IBOutlet weak var playerView: YTPlayerView!
    var comingVideoDict = [String:Any]()
    var videoListArray = NSMutableArray()
    private var videoTabListPresenter = HomeVideoListPresenter()
    var paginationEnabled = false
    private var nexPageTokenForVideoDetailsTab = ""
    private var TotalPageCountVideoDetails = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
       videoTabListPresenter.attachView(view: self)
            if let mDict = comingVideoDict["id"] as? [String:Any] {
                if let videoId = mDict["videoId"] as? String {
                    
                    print("-------> video id is \(videoId)")
                    self.startVideo(id:videoId)
                    //self.tablecelldelagete?.passToVideoControler(videoId:videoId, Index: self.IndexNumber)
                }
            }
       
      
        self.setUpDetails()
        self.callApi()

        // Do any additional setup after loading the view.
    }
    
    func startVideo(id:String){
        playerView.load(withVideoId: id)
      
    }
    
    func setUpDetails(){
        if let firstDict = comingVideoDict["snippet"] as? [String:Any] {
            print("first dict is \(firstDict)")
            
            if let titiletext = firstDict["title"] as? String {
                //cell.mVideotittle.text = titiletext
                print("text is \(titiletext)")
                if let descriptionText = firstDict["description"] as? String {
                    print("description is \(descriptionText)")
                    self.detailTextView.text = "\(titiletext)\n\(descriptionText)"
                    var frame = self.detailTextView.frame
                    frame.size.height = self.detailTextView.contentSize.height
                     self.detailViewHeigthConstraint.constant = self.detailTextView.contentSize.height
                }

            }
        }
    }
    func callApi(){
        if Reachability.isConnectedToNetwork(){
              videoTabListPresenter.videoFromApi(taskUrl: YouTubeApiKeyUrl, method: "GET", parameters: nil, task: "", pageToken: "")
        }else {
            
        }
        
    }
    
    func setUpByJsoan () {
        
                guard let fileUrl = Bundle.main.url(forResource: "youtube", withExtension: "json") else {
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
                             self.videoDetailsTableView.reloadData()
                            
                        }
                       
        
        
                    }
        
        
                } catch {
                    // Print error if something went wrong
                    print("Error: \(error)")
                }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
       self.dismiss(animated: true, completion: nil)
    }
    

}

extension VideoDetailsViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.videoListArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoDetailTableCell", for:indexPath) as! VideoDetailTableCell
            
        if let firstArray = self.videoListArray[indexPath.row] as? [String:Any] {
           
            if let firstDict = firstArray["snippet"] as? [String:Any] {
            
                
                if let titiletext = firstDict["title"] as? String {
                    cell.VideoContentView.text = titiletext
                    print("text is \(titiletext)")
                }
                
                
                if let secoundDict = firstDict["thumbnails"] as? [String:Any] {
                  
                    if let thirdDict = secoundDict["medium"] as? [String:Any]{
          
                        if let imageUrl = thirdDict["url"] as? String{
                        
                            cell.videoImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
                        }
                    }
                }
            }
        }
       
            
            return cell
    
        
    }
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let firstArray = self.videoListArray[indexPath.row] as? [String:Any] {
     
            
           self.comingVideoDict = firstArray
            
            if let mDict = comingVideoDict["id"] as? [String:Any] {
                if let videoId = mDict["videoId"] as? String {
                    
                    print("-------> video id is \(videoId)")
                    self.setUpDetails()
                    //self.callApi()
                    self.startVideo(id:videoId)
                   
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.videoListArray.count - 1 {
            
            if self.videoListArray.count == TotalPageCountVideoDetails {
                print("all videos fetched")
            }else {
                print("Now calling api again")
                
                if nexPageTokenForVideoDetailsTab == "" {
                    
                }else {
                     videoTabListPresenter.videoFromApi(taskUrl: "\(YouTubeApiKey)&pageToken=\(nexPageTokenForVideoDetailsTab)", method: "GET", parameters: nil, task: "", pageToken: "")
                }
               
            }
            
            
        }
        
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 122;//Choose your custom row height
    }
    
}


extension VideoDetailsViewController:VideoListView{
    func responseOfVideoListApi(dict: NSDictionary, statusCode: Int) {
        if statusCode == 200 {
            if let pageInfoDict = dict["pageInfo"] as? [String:Any]{
                if let totalPage = pageInfoDict["totalResults"] as? Int {
                    self.TotalPageCountVideoDetails = totalPage
                }
            }
            
            if let pageToken = dict["nextPageToken"] as? String {
                self.nexPageTokenForVideoDetailsTab = pageToken
                
            }
            
            if let mdict = dict["items"] as? NSArray {
                self.videoListArray.addObjects(from: mdict as! [Any])
                
                print("Container Array is \(videoListArray.count)")
                
                
                DispatchQueue.main.async {
                   
                    self.videoDetailsTableView.reloadData()
                }
              
            }
        }else {
            self.videoListArray.removeAllObjects()
            if nexPageTokenForVideoDetailsTab == ""{
                self.setUpByJsoan()
            }
            
        }
        
        
    }
    
}
