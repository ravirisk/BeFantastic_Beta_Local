//
//  QuotesPresenter.swift
//  Be Fantastic
//
//  Created by Ravi on 06/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import Foundation


protocol QuotesView: NSObjectProtocol {
    
    func responseOfQuotesApi(dict: NSDictionary, statusCode:Int)
    
}

class  QuotesPresenter {
    
    let recordKey = "record"
    private var quotesView: QuotesView?
    var results: [[String: String]]!         // the whole array of dictionaries
    var currentDictionary: [String: String]! // the current dictionary
    var currentValue: String?
    let dictionaryKeys = ["EmpName", "EmpPhone", "EmpEmail", "EmpAddress", "EmpAddress1"]

    
    init() {  }
    
    func attachView(view: QuotesView) {
        quotesView = view
    }
    
    func detachView() {
        quotesView = nil
        
    }
    
    func quotesFromApi(Url:String,method:String,parameters:Any?) {
        print("method has been called of create order")
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue of create order")
            
            
            
            let request = NSMutableURLRequest(url: NSURL(string: QuotesApiUrl)! as URL)
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
                        if  let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? String {
                            print("main json response is \(json)")
//                            self.quotesView?.responseOfQuotesApi(dict: json, statusCode: ((response as? HTTPURLResponse)?.statusCode)!)
                        }

                    } catch {
                        print("error is \(error)")
                    }
                }
            })
            
            task.resume()
            
        }
    }
}

