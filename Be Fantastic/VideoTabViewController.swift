//
//  VideoTabViewController.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class VideoTabViewController: UIViewController {
    
    @IBOutlet weak var videoCollectionView: UICollectionView!
    var videoArray = NSMutableArray()
     private var videoTabListPresenter = HomeVideoListPresenter()
    var paginationEnabled = false
   private var nexPageTokenForVideoTab = ""
   private var TotalPageCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.videoTabListPresenter.attachView(view: self)
        
        let flow = videoCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flow.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        flow.minimumInteritemSpacing = 10
        
        if Reachability.isConnectedToNetwork(){
           
            self.callVideoApi()
        }else {
            CommonClass.sharedCommon.showBasicAlert(on: self, with: BasicAlertTitle, message: InternetConnectionMessage)
        }
        
        
    }
    
    func callVideoApi(){
          videoTabListPresenter.videoFromApi(taskUrl: YouTubeApiKeyUrl, method: "GET", parameters: nil, task: "", pageToken: "")

    }
    
    
    func callJSON(){
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
             
                self.videoArray.addObjects(from: mdict as! [Any])
                DispatchQueue.main.async {
                   self.videoCollectionView.reloadData()
                    
                }
                
               
                print("Container Array is \(videoArray.count)")
                
            }
            
            
        } catch {
            // Print error if something went wrong
            print("Error: \(error)")
        }
       
    }
    
    
    @objc func passToVideoControllerAction(sender: UIButton) {
        print("Button \(sender.tag) Clicked")
        
            if let firstArray = self.videoArray[sender.tag] as? [String:Any] {
                print("first array is \(firstArray)")
                if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "VideoDetailsViewController") as? VideoDetailsViewController{
                    print("------------> Video Details Screen Open")
                    vc.comingVideoDict = firstArray
                    self.present(vc, animated: true, completion: nil)
                }
             
                
            }
      
    }
    
    
    
    
    
    @objc func editGroupAction(sender: UIButton) {
        print("Button \(sender.tag) Clicked")
       
            
            if let firstArray = self.videoArray[sender.tag] as? [String:Any] {
                print("first array is \(firstArray)")
                
                if let mDict = firstArray["id"] as? [String:Any] {
                    if let videoId = mDict["videoId"] as? String {
                        if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "YouTubeVideoViewController") as? YouTubeVideoViewController{
                            print("video play")
                            vc.comingVideoID = videoId
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    }
             }
         }
    }
    
}
    
extension VideoTabViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.videoArray.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("method call of collectionview")
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoTabCell", for: indexPath as IndexPath) as! VideoTabCell
        cell.videoPlayButton.tag = indexPath.row
        cell.videoPlayButton.addTarget(self, action: #selector(editGroupAction(sender:)), for: .touchUpInside)
        cell.videoDetailsButton.tag = indexPath.row
        cell.videoDetailsButton.addTarget(self, action: #selector(passToVideoControllerAction(sender:)), for: .touchUpInside)
        
        
        if let firstArray = self.videoArray[indexPath.row] as? [String:Any] {
           
            
            if let firstDict = firstArray["snippet"] as? [String:Any] {
               
                if let titiletext = firstDict["title"] as? String {
                    cell.videoTitleButton.text = titiletext
                  
                }
                
                if let secoundDict = firstDict["thumbnails"] as? [String:Any] {
                  
                    if let thirdDict = secoundDict["medium"] as? [String:Any]{
                      
                        if let imageUrl = thirdDict["url"] as? String{
                         
                            cell.mVideoImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))
                        }
                    }
                }
            }
        }
        
        
        
        return cell
    }
    
  
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.videoArray.count - 1 {
            
            if self.videoArray.count == TotalPageCount {
                print("all videos fetched")
            }else {
                print("Now calling api again")
                if nexPageTokenForVideoTab == "" {
                    
                }else {
                          videoTabListPresenter.videoFromApi(taskUrl: "\(YouTubeApiKey)&pageToken=\(nexPageTokenForVideoTab)", method: "GET", parameters: nil, task: "", pageToken: "")
                }
             
            }
            
 
        }
       
    }
  
    
}

extension VideoTabViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let numberofItem: CGFloat = 2
        
        let collectionViewWidth = self.videoCollectionView.bounds.width
        
        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
        
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        
        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
        
      //  let finalheigth = Int(self.videoCollectionView.bounds.height / 2 - 5)
        
        print(width)
        
        return CGSize(width: width, height: width)
    }
    
    
}

extension VideoTabViewController:VideoListView{
    func responseOfVideoListApi(dict: NSDictionary, statusCode: Int) {
        if statusCode == 200 {
            if let pageInfoDict = dict["pageInfo"] as? [String:Any]{
                if let totalPage = pageInfoDict["totalResults"] as? Int {
                    self.TotalPageCount = totalPage
                }
            }
            
            if let pageToken = dict["nextPageToken"] as? String {
                self.nexPageTokenForVideoTab = pageToken
                
            }
            
            if let mdict = dict["items"] as? NSArray {
                self.videoArray.addObjects(from: mdict as! [Any])
               
                print("Container Array is \(videoArray.count)")
                

                DispatchQueue.main.async {
                    // Perform your async code here
                    self.videoCollectionView.reloadData()
                }
//
            }
        }else {
            self.videoArray.removeAllObjects()
            if nexPageTokenForVideoTab == ""{
                self.callJSON()
            }
            
        }
        
        
    }
    
}
