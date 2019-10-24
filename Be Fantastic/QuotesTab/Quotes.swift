//
//  Quotes.swift
//  Be Fantastic
//
//  Created by Flywheel on 06/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//
//import UIKit
//
//
//let BASE_URL = "https://api.flickr.com/services/rest/"
//let METHOD_NAME:String! = "flickr.photos.search"
//let API_KEY:String! = “APIKEY GOES HERE”
//let GALLERY_ID:String! = "5704-72157622566655097"
//let EXTRAS:String! = "url_m"
//let DATA_FORMAT:String! = "json"
//let SAFE_SEARCH:String!="1"
//let NO_JSON_CALLBACK:String! = "1"
//
//class ViewController: UIViewController {
//    //below are arrays that save all the images related to the keyword
//    //so that we can show them later when the Next button is pressed
//    var photoArray2: AnyObject!=[String: AnyObject]()
//    
//    var iNamey=[String]()
//    var iImage=[String]()
//    var iImageUrl=[NSURL]()
//    
//    var counter=0;
//    
//    
//    @IBOutlet weak var mainImg: UIImageView!
//    
//    
//    @IBOutlet weak var searchText: UITextField!
//    
//    @IBOutlet weak var searchButton: UIButton!
//    
//    
//    
//    
//    
//    
//    
//    @IBOutlet weak var titleLabel: UILabel!
//    
//    
//    
//    @IBAction func searchAction(sender: AnyObject) {//
//        let word:String! = searchText.text
//        print(word)
//        /* 2 - API method arguments */
//        var methodArguments = [
//            "method": METHOD_NAME,
//            "api_key": API_KEY,
//            "text": word,
//            "safe_search": SAFE_SEARCH,
//            "extras": EXTRAS,
//            "format": DATA_FORMAT,
//            "nojsoncallback": NO_JSON_CALLBACK
//        ]
//        if methodArguments.isEmpty {
//        }else{
//            getImageFromFlickrSearch(methodArguments)//passes API Key and search term to method
//        }
//        //as! [String : AnyObject])
//        
//        
//    }
//    
//    @IBAction func geoAction(sender: AnyObject) {
//    }
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func getImageFromFlickrSearch(methodArguments:[String : String!]) {
//        
//        
//        /* 3 - Initialize session and url  - Use NSURLSessions to connect */
//        let session = NSURLSession.sharedSession()
//        let urlString = BASE_URL + escapedParameters(methodArguments)
//        print(urlString)
//        let url = NSURL(string: urlString)!
//        let request = NSURLRequest(URL: url)
//        
//        /* 4 - Initialize task for getting data  - initialize task*/
//        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
//            if let error = downloadError {
//                print("Could not complete the request \(error)")
//            } else {
//                /* 5 - Success! Parse the data */
//                var parsingError: NSError? = nil
//                let parsedResult: AnyObject!
//                do {
//                    parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
//                } catch let error as NSError {
//                    parsingError = error
//                    parsedResult = nil
//                } catch {
//                    fatalError()
//                }
//                
//                if let photosDictionary = parsedResult.valueForKey("photos") as? NSDictionary {
//                    if let photoArray = photosDictionary.valueForKey("photo") as? [[String: AnyObject]] {
//                        
//                        
//                        for (var index = 0; index < photoArray.count; ++index ){
//                            let photoDictionary = photoArray[index] as [String: AnyObject]
//                            
//                            
//                            let photoTitle = photoDictionary["title"] as? String
//                            var imageUrlString = photoDictionary["url_m"] as? String
//                            if(imageUrlString==nil){
//                            }else{
//                                let imageURL = NSURL(string: imageUrlString!)
//                                /* 7 - Save info to arrays  */
//                                self.iNamey.append(photoTitle!)
//                                self.iImage.append(imageUrlString!)
//                                self.iImageUrl.append(imageURL!)
//                            }
//                            
//                            
//                        }
//                        /* 6 - Grab a single, random image */
//                        let randomPhotoIndex = Int(arc4random_uniform(UInt32(self.iNamey.count)))
//                        
//                        
//                        let photoDictionary = photoArray[randomPhotoIndex] as [String: AnyObject]
//                        
//                        /* 7 - Get the image url and title of random image */
//                        let photoTitle = photoDictionary["title"] as? String
//                        let imageUrlString = photoDictionary["url_m"] as? String
//                        let imageURL = NSURL(string: imageUrlString!)
//                        
//                        /* 8 - If an image exists at the url, set the image and title to storyboard*/
//                        if let imageData = NSData(contentsOfURL: imageURL!) {
//                            dispatch_async(dispatch_get_main_queue(), {
//                                self.mainImg.image = UIImage(data: imageData)
//                                self.titleLabel.text = photoTitle
//                            })
//                        } else {
//                            print("Image does not exist at \(imageURL)")
//                        }
//                    } else {
//                        print("Cant find key 'photo' in \(photosDictionary)")
//                    }
//                } else {
//                    print("Cant find key 'photos' in \(parsedResult)")
//                }
//            }
//        }
//        
//        /* 9 - Resume (execute) the task */
//        task.resume()
//    }
//    
//    /* Helper function: Given a dictionary of parameters, convert to a string for a url */
//    func escapedParameters(parameters: [String : String!]) -> String! {
//        
//        var urlVars = [String]()
//        
//        for (key, value) in parameters {
//            
//            /* Make sure that it is a string value */
//            let stringValue = "\(value)"
//            
//            /* Escape it */
//            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
//            
//            /* Append it */
//            urlVars += [key + "=" + "\(escapedValue!)"]
//            
//        }
//        
//        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
//    }
//    
//    
//    
//    
//    @IBAction func NextImg(sender: AnyObject) {
//        nextPerson()
//    }
//    
//    
//    
//    func nextPerson(){
//        
//        
//        /* 8 - If an image exists at the url, set the image and title */
//        if let imageData = NSData(contentsOfURL: iImageUrl[counter]) {
//            dispatch_async(dispatch_get_main_queue(), {
//                self.mainImg.image = UIImage(data: imageData)
//                self.titleLabel.text = self.iNamey[self.counter]
//                self.counter++
//                if(self.counter==self.iNamey.count){
//                    self.counter=0;
//                }
//            })
//        } else {
//            print("Image does not exist at \(iImageUrl[0])")
//        }    }//end of method
//    
//    
//    
//    
//    
//}
//
