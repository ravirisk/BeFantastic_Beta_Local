//
//  HomeTableCell.swift
//  Be Fantastic
//
//  Created by Ravi on 25/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import SDWebImage

protocol TableCellDelegate {
    func passToVideoControler(videoId:String,Index:Int)
    func passToVideoDetailsController(videoDict:[String:Any],Index:Int)
   
}


class HomeTableCell: UITableViewCell {
    private var homeVideoListPresenter = HomeVideoListPresenter()
    @IBOutlet weak var mCollectionView: UICollectionView!
    var youTubeVideoArrayofInterviews = NSMutableArray()
    var youTubeVideoArrayofAskAnyThing = NSMutableArray()
    
    var numberOfitemperScreen = 2
    
     var tablecelldelagete:TableCellDelegate?
    private var IndexNumber = Int()
     var firstcellArray = ["FantasticMovemnt","DrFantasticAbout"]
    var secoundArray = ["Screenshot 2019-09-27 at 2.45.42 AM.png","Screenshot 2019-09-27 at 2.45.42 AM.png","Screenshot 2019-09-27 at 2.45.42 AM.png","Screenshot 2019-09-27 at 2.45.42 AM.png"]
    
    var thirdArray = ["AskAnyThing","AskAnyThing","AskAnyThing","AskAnyThing"]
    
    var fourthArray = ["Radio.png","Podcast.png"]
    
    @IBOutlet weak var cellTittleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
        mCollectionView.dataSource = self
        mCollectionView.delegate = self
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
               
                    self.youTubeVideoArrayofInterviews.addObjects(from: mdict as! [Any])
                    self.mCollectionView.reloadData()
                    print("Container Array is \(youTubeVideoArrayofInterviews.count)")
              
            }
            
            
        } catch {
            // Print error if something went wrong
            print("Error: \(error)")
        }
    }
    
    func setupLayout() {
        
        if IndexNumber == 0 {
            let flow = mCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            
            flow.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            
            flow.minimumInteritemSpacing = 10
           
        }else {
           
            let layout = UPCarouselFlowLayout()
             //layout.itemSize = CGSizeMake(200, 200)
             layout.itemSize = CGSize(width: self.mCollectionView.bounds.width, height: self.mCollectionView.bounds.height)
            layout.scrollDirection = .horizontal
            layout.spacingMode = .fixed(spacing: 0.8)
            self.mCollectionView.collectionViewLayout = layout
        }
        
    }
    
    func callApi(data:Int){
       self.IndexNumber = data
        print("Index number is \(data)")
        
        
        if IndexNumber == 0 {
             self.mCollectionView.reloadData()
            
        }else if IndexNumber == 1 {
            
           self.setUpManualy()
           
        }else if IndexNumber == 2 {
            print("different cell is loaded")
  
        }else if IndexNumber == 3 {
              self.mCollectionView.reloadData()
        }else if IndexNumber == 4 {
            self.mCollectionView.reloadData()
        }
        
      
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    deinit {
         homeVideoListPresenter.detachView()
    }
    
    
    @objc func editGroupAction(sender: UIButton) {
        print("Button \(sender.tag) Clicked")
        
        if IndexNumber == 0 {
            self.tablecelldelagete?.passToVideoControler(videoId:self.firstcellArray[sender.tag], Index: self.IndexNumber)
            
        }else if IndexNumber == 1 {
            
            if let firstArray = self.youTubeVideoArrayofInterviews[sender.tag] as? [String:Any] {
                print("first array is \(firstArray)")
                
                if let mDict = firstArray["id"] as? [String:Any] {
                    if let videoId = mDict["videoId"] as? String {
                        
                        print("-------> video id is \(videoId)")
                        self.tablecelldelagete?.passToVideoControler(videoId:videoId, Index: self.IndexNumber)
                    }
                }
            }
            
            
        }else if IndexNumber == 2 {
            self.tablecelldelagete?.passToVideoControler(videoId:"YA58nrHBrOE", Index: self.IndexNumber)
            
        }else if IndexNumber == 4 {
            
            self.tablecelldelagete?.passToVideoControler(videoId:self.fourthArray[sender.tag], Index: self.IndexNumber)
            
        }
    }
    
    @objc func passToVideoControllerAction(sender: UIButton) {
        print("Button \(sender.tag) Clicked")
        
        if IndexNumber == 0 {
           // self.tablecelldelagete?.pass(videoId:"", Index: self.IndexNumber)
            
        }else if IndexNumber == 1 {
            
            if let firstArray = self.youTubeVideoArrayofInterviews[sender.tag] as? [String:Any] {
                print("first array is \(firstArray)")
                
               
                        self.tablecelldelagete?.passToVideoDetailsController(videoDict: firstArray, Index: IndexNumber)
               
            }
            
            
        }else if IndexNumber == 2 {
           self.tablecelldelagete?.passToVideoControler(videoId:"", Index: self.IndexNumber)
            
        }else if IndexNumber == 3 {
            
          self.tablecelldelagete?.passToVideoControler(videoId:"", Index: self.IndexNumber)
            
        }
    }

}

extension HomeTableCell:VideoListView{
  func responseOfVideoListApi(dict: NSDictionary, statusCode: Int) {
        if statusCode == 200 {
           
            
            if let mdict = dict["items"] as? NSArray {
               // self.youTubeVideoArray.removeAllObjects()
                
                if IndexNumber == 1 {
                      self.youTubeVideoArrayofInterviews.addObjects(from: mdict as! [Any])
                }else {
                      self.youTubeVideoArrayofAskAnyThing.addObjects(from: mdict as! [Any])
                }
               
              
                
                print("count of video array is \(self.youTubeVideoArrayofAskAnyThing.count)")

                DispatchQueue.main.async {
                     // Perform your async code here
                      self.mCollectionView.reloadData()
                }

            }
        }else {


        }
    
        
       }
    
    }



extension HomeTableCell:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if IndexNumber == 0 {
          return 2
            
        }else if IndexNumber == 1 {
            
           return self.youTubeVideoArrayofInterviews.count
            
        }else if IndexNumber == 2 {
            return self.youTubeVideoArrayofAskAnyThing.count
            
        }else if IndexNumber == 3 {
            
          return 2
            
        }
        
        return 2
       
    }


    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               print("method call of collectionview")
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath as IndexPath) as! HomeCollectionViewCell
        
        cell.cellButton.tag = indexPath.row
        cell.cellButton.addTarget(self, action: #selector(editGroupAction(sender:)), for: .touchUpInside)


        
        if IndexNumber == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCollectionCell", for: indexPath as IndexPath) as! NormalCollectionCell
            
            cell.normalcellButton.tag = indexPath.row
            cell.normalcellButton.addTarget(self, action: #selector(editGroupAction(sender:)), for: .touchUpInside)
            
            

            cell.normalCellImageView.image = UIImage(named: self.firstcellArray[indexPath.row])
            
            return cell

        }else if IndexNumber == 1 {
         
        }else if IndexNumber == 2 {

        }else if IndexNumber == 4 {
            print(">>>>>>>>>>>>>>>>> on the 4th index")
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCollectionCell", for: indexPath as IndexPath) as! NormalCollectionCell
            
            cell.normalcellButton.tag = indexPath.row
            cell.normalcellButton.addTarget(self, action: #selector(editGroupAction(sender:)), for: .touchUpInside)

            cell.normalCellImageView.image = UIImage(named: self.fourthArray[indexPath.row] )
            
             return cell

        }


        return cell
    }
    

    
}



extension HomeTableCell: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        if IndexNumber == 2 {
           numberOfitemperScreen = 1
        }else{
           numberOfitemperScreen = 2
        }
        
        let numberofItem: CGFloat = CGFloat(numberOfitemperScreen)
        
        let collectionViewWidth = self.mCollectionView.bounds.width
        
        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
        
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        
        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
        
        print(width)
        
        if IndexNumber == 2 {
                 numberOfitemperScreen = 1
             return CGSize(width: width, height: width)
            }else{
                 numberOfitemperScreen = 2
             return CGSize(width: width, height: width - 18)
        }
        
        return CGSize(width: width, height: width)
    }
    
}

extension HomeTableCell:UICollectionViewDelegate {
    private func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
      
        // Init your segue transition here
    }
}

