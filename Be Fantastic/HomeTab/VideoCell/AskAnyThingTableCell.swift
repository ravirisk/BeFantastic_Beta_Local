//
//  AskAnyThingTableCell.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class AskAnyThingTableCell: UITableViewCell {

    @IBOutlet weak var askAnythingViewAllButton: UIButton!
    
    @IBOutlet weak var nCollectionView: UICollectionView!
    
    @IBOutlet weak var askTitleLabel: UILabel!
    private var homeVideoListPresenter = HomeVideoListPresenter()
    
    var youtubeVideoArray = NSMutableArray()
    
       var thirdArray = ["AskAnyThing","AskAnyThing","AskAnyThing"]
   
     var tablecelldelagete:TableCellDelegate?
     private var IndexNumber = Int()
    private var nexPageTokenForAskAnythingCell = ""
    private var TotalPageCountAskAnything = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nCollectionView.dataSource = self
        nCollectionView.delegate = self
        homeVideoListPresenter.attachView(view: self)
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
            print("whole dict is \(dictionary)")
            
            if let mdict = dictionary["items"] as? NSArray {
                print("m dict is \(mdict)")
                
                self.youtubeVideoArray.addObjects(from: mdict as! [Any])
                self.nCollectionView.reloadData()
                print("Container Array is \(youtubeVideoArray.count)")
                
            }
            
            
        } catch {
            // Print error if something went wrong
            print("Error: \(error)")
        }
    }
    
    
    func setupLayout() {
        let layout = UPCarouselFlowLayout()
       // layout.itemSize = CGSizeMake(200, 200)
        
        layout.itemSize = CGSize(width: self.nCollectionView.bounds.width , height: self.nCollectionView.bounds.height)
        layout.scrollDirection = .horizontal
        layout.spacingMode = .fixed(spacing: 0.8)
        self.nCollectionView.collectionViewLayout = layout
        
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func editGroupAction(sender: UIButton) {
        print("Button \(sender.tag) Clicked")
        
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
    
    @objc func passToVideoControllerAction(sender: UIButton) {
        print("Button \(sender.tag) Clicked")
        
       
            if let firstArray = self.youtubeVideoArray[sender.tag] as? [String:Any] {
                print("first array is \(firstArray)")
               
                self.tablecelldelagete?.passToVideoDetailsController(videoDict: firstArray, Index: IndexNumber)
                
            }
        
    }
    
    func callApiFor(data:Int){
        self.IndexNumber = data
        print("Index number is \(data)")
        homeVideoListPresenter.videoFromApi(taskUrl: YouTubeApiKeyUrl, method: "GET", parameters: nil, task: "", pageToken: "")
        
    }

}


extension AskAnyThingTableCell:VideoListView{
    func responseOfVideoListApi(dict: NSDictionary, statusCode: Int) {
        if statusCode == 200 {
            print("api response come")
            if let pageInfoDict = dict["pageInfo"] as? [String:Any]{
                if let totalPage = pageInfoDict["totalResults"] as? Int {
                    self.TotalPageCountAskAnything = totalPage
                }
            }
            
            if let pageToken = dict["nextPageToken"] as? String {
                self.nexPageTokenForAskAnythingCell = pageToken
                
            }
            if let mdict = dict["items"] as? NSArray {
                
                self.youtubeVideoArray.addObjects(from: mdict as! [Any])
                print("count of array is \(self.youtubeVideoArray.count)")
                DispatchQueue.main.async {
                    // Perform your async code here
                    self.nCollectionView.reloadData()
                    
                    
                }
                
            }
        }else {
            self.youtubeVideoArray.removeAllObjects()
            if nexPageTokenForAskAnythingCell == "" {
               self.setUpManualy()
            }
            
            
        }
        
        
    }

}
extension AskAnyThingTableCell:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.youtubeVideoArray.count
        
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("method call of collectionview")
        // get a reference to our storyboard cell
      
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AskAnythingCollectionCell", for: indexPath as IndexPath) as! AskAnythingCollectionCell
            
          //  cell.askAnythingButton.tag = indexPath.row
        cell.askAnythingButton.tag = indexPath.row
        cell.askAnythingButton.addTarget(self, action: #selector(editGroupAction(sender:)), for: .touchUpInside)

        cell.askAnythingVideoDetailsButton.tag = indexPath.row
        cell.askAnythingVideoDetailsButton.addTarget(self, action: #selector(passToVideoControllerAction(sender:)), for: .touchUpInside)

            if let firstArray = self.youtubeVideoArray[indexPath.row] as? [String:Any] {
          

                if let firstDict = firstArray["snippet"] as? [String:Any] {
               
                    if let titiletext = firstDict["title"] as? String {
                       cell.mVideotittle.text = titiletext
                      
                    }


                    if let secoundDict = firstDict["thumbnails"] as? [String:Any] {
                        if let thirdDict = secoundDict["medium"] as? [String:Any]{
                        
                            if let imageUrl = thirdDict["url"] as? String{
                                print(imageUrl)
                                cell.thumbnailImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
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
            if self.youtubeVideoArray.count == TotalPageCountAskAnything {
                print("all videos fetched")
            }else {
                print("Now calling api again")
                homeVideoListPresenter.videoFromApi(taskUrl: "\(YouTubeApiKey)&pageToken=\(nexPageTokenForAskAnythingCell)", method: "GET", parameters: nil, task: "", pageToken: "")
            }
            
            
        }
        
    }
    
}



//extension AskAnyThingTableCell: UICollectionViewDelegateFlowLayout {
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//
//        let numberofItem: CGFloat = 1
//
//        let collectionViewWidth = self.nCollectionView.bounds.width
//
//        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
//
//        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
//
//        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
//
//        print(width)
//
//        return CGSize(width: width, height: width)
//    }
//
//}
