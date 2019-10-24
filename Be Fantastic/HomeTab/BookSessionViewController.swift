//
//  BookSessionViewController.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import MessageUI

class BookSessionViewController: UIViewController {

    @IBOutlet weak var CommentsFieldText: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var phonenumberTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var SubmitButtonOutlets: UIButton!
    @IBOutlet weak var fifthView: UIView!
    @IBOutlet weak var fourthView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var secoundView: UIView!
    @IBOutlet weak var firstView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeView()
//
//       firstView.setRadius()
//        secoundView.setRadius()
//        thirdView.setRadius()
//        fourthView.setRadius()
//        firstView.setRadius()
        // Do any additional setup after loading the view.
    }
    func customizeView(){
        SubmitButtonOutlets.layer.cornerRadius = 10
        SubmitButtonOutlets.clipsToBounds = true
        firstView.layer.cornerRadius = 10
        firstView.clipsToBounds = true
        secoundView.layer.cornerRadius = 10
        secoundView.clipsToBounds = true
        thirdView.layer.cornerRadius = 10
        thirdView.clipsToBounds = true
        fourthView.layer.cornerRadius = 10
        fourthView.clipsToBounds = true
        fifthView.layer.cornerRadius = 10
        fifthView.clipsToBounds = true
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func SubmitButton(_ sender: UIButton) {
        self.validateFields()
        
    }
    
    func validateFields(){
        guard let emailId =  emailIdTextField.text, !emailId.isEmpty else {
            CommonClass.sharedCommon.showBasicAlert(on: self, with: BasicAlertTitle, message: BlankFieldAlertMessage)
            return
        }
        
        guard let name = self.nameTextField.text, !name.isEmpty else {
            CommonClass.sharedCommon.showBasicAlert(on: self, with: BasicAlertTitle, message: BlankFieldAlertMessage)
            return
        }
        
        
        
        guard let phonnumber = self.phonenumberTextField.text, !phonnumber.isEmpty else {
            CommonClass.sharedCommon.showBasicAlert(on: self, with: BasicAlertTitle, message: BlankFieldAlertMessage)
            return
        }
        
        guard let comment = self.CommentsFieldText.text, !comment.isEmpty else {
            CommonClass.sharedCommon.showBasicAlert(on: self, with: BasicAlertTitle, message: BlankFieldAlertMessage)
            return
        }
        
        self.emailIdTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.phonenumberTextField.resignFirstResponder()
        self.CommentsFieldText.resignFirstResponder()
       self.sendMail()
    }
    
    func sendMail(){
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["oneqwertysys@qwertysysonline.com"])
        composeVC.setSubject("Book the Session")
        composeVC.setMessageBody(self.CommentsFieldText.text!, isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    

}

extension BookSessionViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
