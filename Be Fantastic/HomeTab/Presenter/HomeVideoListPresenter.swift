//
//  HomeVideoListPresenter.swift
//  Be Fantastic
//
//  Created by Ravi on 23/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import Foundation

protocol VideoListView: NSObjectProtocol {
    
    func responseOfVideoListApi(dict: NSDictionary, statusCode:Int)
    
}

class HomeVideoListPresenter {
    
    private var videoListView: VideoListView?
    
    init() {  }
    
    func attachView(view: VideoListView) {
         videoListView = view
    }
    
    func detachView() {
         videoListView = nil
        
    }
    
    func videoFromApi(taskUrl:String,method:String,parameters:Any?,task:String,pageToken:String) {
        print("method has been called of create order")

        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue of create order")
    

            let request = NSMutableURLRequest(url: NSURL(string: YouTubeApiKeyUrl)! as URL)
            let session = URLSession.shared
            request.httpMethod = method
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
          

            if method == "POST" {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
                } catch let error {
                    print(error.localizedDescription)
                }

            }

            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error -> Void in
                if error != nil {
                    print("Error: \(String(describing: error))")
                } else {
                    print("Response: \(String(describing: response)) and data is \(data)")

                    print("status code is \(((response as? HTTPURLResponse)?.statusCode)!)")

                    do {
                        if  let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary {
                            print("main json response is \(json)")
                            self.videoListView?.responseOfVideoListApi(dict: json, statusCode: ((response as? HTTPURLResponse)?.statusCode)!)
                        }

                    } catch {
                        print("error")
                    }
                }
            })

            task.resume()

            }
        }
    }
    
