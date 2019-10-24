//
//  FantasticInterviewTableCell.swift
//  Be Fantastic
//
//  Created by Flywheel on 05/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit


class FantasticInterviewTableCell: UITableViewCell {

    @IBOutlet weak var leadingConstrainOfCollectionView: NSLayoutConstraint!
    @IBOutlet weak var askViewAllButton: UIButton!
    @IBOutlet weak var fcollectionView: UICollectionView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    private var homeVideoListPresenter = HomeVideoListPresenter()
    
    var youtubeVideoArray = NSMutableArray()
   var adayInlifeArray = NSMutableArray()
    var didScrollToSecondIndex = false
    private var nexPageTokenForInterviewCell = ""
    private var TotalPageCountInterview = 0
    var senderTag = -1
    
    var thirdArray = ["AskAnyThing","AskAnyThing","AskAnyThing"]
    
    var tablecelldelagete:TableCellDelegate?
    private var IndexNumber = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        fcollectionView.dataSource = self
        fcollectionView.delegate = self
      // self.leadingConstrainOfCollectionView.constant = -60
        self.homeVideoListPresenter.attachView(view: self)
        self.setupLayout()
      
        
    }
    
    
    func setUpManualy(){
        
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
            
            if let mdict = dictionary["items"] as? NSArray {
                print("m dict is \(mdict)")
                
                self.youtubeVideoArray.addObjects(from: mdict as! [Any])
                DispatchQueue.main.async {
                     self.fcollectionView.reloadData()
                  
                   // self.fcollectionView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                    
                }
              
                print("Container Array is \(youtubeVideoArray.count)")
                
            }
            
            
        } catch {
            // Print error if something went wrong
            print("Error: \(error)")
        }
    }
    
    
    func setupLayout() {
        let layout = UPCarouselFlowLayout()
        
        if IndexNumber == 3 {
            
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50 , height: self.fcollectionView.bounds.height + 30 )
            layout.scrollDirection = .horizontal
            
            layout.spacingMode = .fixed(spacing: 10)
            self.fcollectionView.collectionViewLayout = layout
        }else{
            
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50 , height: self.fcollectionView.bounds.height + 20 )
            layout.scrollDirection = .horizontal
            
            layout.spacingMode = .fixed(spacing: 10)
            self.fcollectionView.collectionViewLayout = layout
        }
     

        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func editGroupAction(sender: UIButton) {
        print("Button \(sender.tag) Clicked")
        
        
        if IndexNumber == 3 {
            
            print("count of aday in life array \(self.adayInlifeArray.count)")
            
//            if self.adayInlifeArray.count > 0 {
//
//                                    if let firstArray = self.adayInlifeArray[sender.tag] as? [String:Any] {
//                                        print("first array is \(firstArray)")
//
//                                        if let mDict = firstArray["id"] as? [String:Any] {
//                                            if let videoId = mDict["videoId"] as? String {
//
//                                                print("-------> video id is \(videoId)")
//                                                self.tablecelldelagete?.passToVideoControler(videoId:videoId, Index: self.IndexNumber)
//                                            }
//                                        }
//                                    }
//            }else {
//                print("count is zero ")
//            }

        }else {
            
                    if let firstArray = self.youtubeVideoArray[sender.tag] as? [String:Any] {
                        print("first array is \(firstArray)")
            
                        if let mDict = firstArray["id"] as? [String:Any] {
                            if let videoId = mDict["videoId"] as? String {
            
                                print("-------> video id is \(videoId)")
                                self.tablecelldelagete?.passToVideoControler(videoId:videoId, Index: self.IndexNumber)
                            }
                        }
                    }
        }

        
        
    }
    
    @objc func passToVideoControllerAction(sender: UIButton) {
        print("Button \(sender.tag) Clicked")
        
        if IndexNumber == 3 {
            
            if let firstArray = self.adayInlifeArray[sender.tag] as? [String:Any] {
                print("first array is \(firstArray)")
                
                self.tablecelldelagete?.passToVideoDetailsController(videoDict: firstArray, Index: IndexNumber)
                
            }
        }else {
            if let firstArray = self.youtubeVideoArray[sender.tag] as? [String:Any] {
                print("first array is \(firstArray)")
                
                self.tablecelldelagete?.passToVideoDetailsController(videoDict: firstArray, Index: IndexNumber)
                
            }
        }
       
        
    }
    
    
    
    func fetchData(){
        if self.IndexNumber == 3 {
            
            print(">>>>>>>>>>> a day in life called")
            guard let fileUrl = Bundle.main.url(forResource: "AdayinLife", withExtension: "json") else {
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
                
                if let mdict = dictionary["items"] as? NSArray {
                    print("m dict is \(mdict)")
                    self.adayInlifeArray.addObjects(from: mdict as! [Any])
                    
                    print("youtube array count for a day in life \(adayInlifeArray.count)")
                    DispatchQueue.main.async {
                        self.fcollectionView.reloadData()
                    }
                    
                    print("Container Array is \(adayInlifeArray.count)")
                    
                }
                
                
            } catch {
                // Print error if something went wrong
                print("Error: \(error)")
            }
        }else {
            print("Index number is \(IndexNumber)")
            homeVideoListPresenter.videoFromApi(taskUrl: YouTubeApiKeyUrl, method: "GET", parameters: nil, task: "", pageToken: "")
        }

    }
    
    func callApiFor(data:Int){
        print(">>>>>>>>>>>>>>>>> call api")
        self.IndexNumber = data
        self.fetchData()
        
//        if youtubeVideoArray.count > 0{
//            print("Do not do anything")
//        }else {
//            self.fetchData()
//        }
//        if adayInlifeArray.count > 0{
//            print("Do not do anything")
//        }else {
//            self.fetchData()
//        }
     
    }
}


extension FantasticInterviewTableCell:VideoListView{
    func responseOfVideoListApi(dict: NSDictionary, statusCode: Int) {
        if statusCode == 200 {
            print("api response come")
            if let pageInfoDict = dict["pageInfo"] as? [String:Any]{
                if let totalPage = pageInfoDict["totalResults"] as? Int {
                    self.TotalPageCountInterview = totalPage
                }
            }
            
            if let pageToken = dict["nextPageToken"] as? String {
                self.nexPageTokenForInterviewCell = pageToken
                
            }
            if let mdict = dict["items"] as? NSArray {
          
                self.youtubeVideoArray.addObjects(from: mdict as! [Any])
                print("count of array is \(self.youtubeVideoArray.count)")
                DispatchQueue.main.async {
                    
                    self.fcollectionView.reloadData()
                   
                  
                }
                
            }
        }else {
              self.youtubeVideoArray.removeAllObjects()
            if nexPageTokenForInterviewCell == ""{
                   self.setUpManualy()
            }
           
            
        }
        
        
    }
    
}
extension FantasticInterviewTableCell:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.IndexNumber == 3 {
            return self.adayInlifeArray.count
        }else {
              return self.youtubeVideoArray.count
        }
        
      
        
    }
  
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("method call of collectionview")
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath as IndexPath) as! HomeCollectionViewCell
        
        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(editGroupAction(sender:)), for: .touchUpInside)
        cell.cellVideoDetailButton.tag = indexPath.row
        cell.cellVideoDetailButton.addTarget(self, action: #selector(passToVideoControllerAction(sender:)), for: .touchUpInside)
        
        if self.IndexNumber == 3 {
            
            if let firstArray = self.adayInlifeArray[indexPath.row] as? [String:Any] {
                
                
                if let firstDict = firstArray["snippet"] as? [String:Any] {
                    
                    if let titiletext = firstDict["title"] as? String {
                        cell.videoTItle.text = titiletext
                        
                    }
                    
                    if let secoundDict = firstDict["thumbnails"] as? [String:Any] {
                        
                        if let thirdDict = secoundDict["medium"] as? [String:Any]{
                            
                            if let imageUrl = thirdDict["url"] as? String{
                                cell.mCollectionImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
                            }
                        }
                    }
                }
            }
        }else{
          
            if let firstArray = self.youtubeVideoArray[indexPath.row] as? [String:Any] {
                
                
                if let firstDict = firstArray["snippet"] as? [String:Any] {
                    
                    if let titiletext = firstDict["title"] as? String {
                        cell.videoTItle.text = titiletext
                        
                    }
                    
                    if let secoundDict = firstDict["thumbnails"] as? [String:Any] {
                        
                        if let thirdDict = secoundDict["medium"] as? [String:Any]{
                            
                            if let imageUrl = thirdDict["url"] as? String{
                                cell.mCollectionImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
                            }
                        }
                    }
                }
            }
        }
      
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("will display called")
        if indexPath.row == self.youtubeVideoArray.count - 1 {
            if self.youtubeVideoArray.count == TotalPageCountInterview {
                print("all videos fetched")
            }else {
                
                if nexPageTokenForInterviewCell == ""{
                    
                }else {
                    print("Now calling api again")
                    homeVideoListPresenter.videoFromApi(taskUrl: "\(YouTubeApiKey)&pageToken=\(nexPageTokenForInterviewCell)", method: "GET", parameters: nil, task: "", pageToken: "")
                }
               
            }
            
            
        }
        
    }
    
}
