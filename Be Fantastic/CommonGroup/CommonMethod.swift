//
//  CommonMethod.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import Foundation


import UIKit


class CommonClass {
    static let sharedCommon = CommonClass()
    
    var nextPageTokenKey = ""
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func validateTextViewText(textView: UITextView) -> Bool {
        guard let text = textView.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                // this will be reached if the text is nil (unlikely)
                // or if the text only contains white spaces
                // or no text at all
                return false
        }
        
        return true
    }
    
    func validateTextFieldText(textView: UITextField) -> Bool {
        guard let text = textView.text,
            !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty else {
                
                return false
        }
        
        return true
    }
    
    func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
        
    }
    
    func saveStringDataInUserDefault(string:String, key:String){
        UserDefaults.standard.setValue(string, forKey: key)
    }
    
    
    
    func fetchStringDataInUserDefault(key:String) -> String{
        if let dataString =  UserDefaults.standard.value(forKey:key) as? String{
            return dataString
        }else {
            return ""
        }
        
        
    }
    
    func saveIntDataInUserDefault(number:Int32, key:String){
        UserDefaults.standard.setValue(number, forKey: key)
    }
    func fetchIntDataInUserDefault(key:String) -> Int32{
        if let dataString =  UserDefaults.standard.value(forKey:key) as? Int32{
            return dataString
        }else {
            return 0
        }
        
        
    }
    
    
    
}
