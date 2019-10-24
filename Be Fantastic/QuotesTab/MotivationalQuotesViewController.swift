//
//  MotivationalQuotesViewController.swift
//  Be Fantastic
//
//  Created by Flywheel on 06/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class MotivationalQuotesViewController: UIViewController {
     @IBOutlet weak var quotesCollectionView: UICollectionView!
    var imageArray = NSMutableArray()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.quotesCollectionView.dataSource = self
        self.quotesCollectionView.delegate = self
      
     
        if Reachability.isConnectedToNetwork() {
            DispatchQueue.global(qos: .background).async {
                print("This is run on the background qu")
               self.callFlickerApi()
            }
        }else {
            
        }
        
    }
    
    func callFlickerApi() {
        Alamofire.request(QuotesApiUrl,
                          method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default,
                          headers: [:])
            .validate(contentType: ["text/xml; charset=utf-8"])
            .responseString  { (response) in
                
                switch(response.result) {
                case .success(let value):
                    print("value is \(value)")
                   self.parseXMLString(comingString: value)
                case .failure(let error):
                    print(error)
                }
             
        }
        
    }
    
    
    func parseXMLString(comingString:String){
    
        do {
            let xmlDictionary = try XMLReader.dictionary(forXMLString: comingString)//XMLReader.dictionary(forXMLString: value, error: nil)

            var jsonData: Data? = nil
            do {
                jsonData = try JSONSerialization.data(withJSONObject: xmlDictionary, options: .prettyPrinted)
            } catch {
            }
            var responseDictionary: [AnyHashable : Any]? = nil
            do {
                if let jsonData = jsonData {
                    responseDictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [AnyHashable : Any]

                    if let photosArray = responseDictionary?["rsp"] as? [AnyHashable:Any]{
                        
                        
                        if let mainArray = photosArray["photos"] as?  [AnyHashable:Any] {
                            print("main Array \(photosArray)")
                            if let flickerArray = mainArray["photo"] as? NSArray {
                                print("main Array \(flickerArray)")
                                 self.imageArray.addObjects(from: flickerArray as! [Any])
                                
                                DispatchQueue.main.async {
                                    self.quotesCollectionView.reloadData()
                                }
                              
                            }
                            
                        }
                        
                    }
                    
                }
            } catch {
            }
            
            
        } catch {
        }
        
    }
   
}



extension MotivationalQuotesViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.imageArray.count
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("method call of collectionview")
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuotesCollectionViewCell", for: indexPath as IndexPath) as! QuotesCollectionViewCell
        
        if let imageDict = self.imageArray[indexPath.row] as? [String:Any] {
            if let photoId = imageDict["id"] as? String {
                
                if let photoOwner = imageDict["owner"] as? String{
                    // let imageUrl = "https://farm4.static.flickr.com/3910/15082177438_9a821fe6e4.jpg"
                    
                    if let framNo = imageDict["farm"] as? String {
                        if let seceretKey = imageDict["secret"] as? String{
                            if let serverKey = imageDict["server"] as? String {
                                
                                cell.quotesImageView.sd_setImage(with: URL(string: "https://farm\(framNo).static.flickr.com/\(serverKey)/\(photoId)_\(seceretKey).jpg"), placeholderImage: UIImage(named: "placeholder.png"))
                            }
                        }
                        
                        
                    }
                    
                    
                    
                }
            }
            
        }
        
        return cell
    }
    

    
}

extension MotivationalQuotesViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
     
        let numberofItem: CGFloat = CGFloat(1)
        
        let collectionViewWidth = self.quotesCollectionView.bounds.width
        
        let extraSpace = (numberofItem - 1) * flowLayout.minimumInteritemSpacing
        
        let inset = flowLayout.sectionInset.right + flowLayout.sectionInset.left
        
        let width = Int((collectionViewWidth - extraSpace - inset) / numberofItem)
        
        print(width)
        
        return CGSize(width: width, height: Int(self.quotesCollectionView.bounds.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
