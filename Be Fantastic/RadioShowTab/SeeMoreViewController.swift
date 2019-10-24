//
//  SeeMoreViewController.swift
//  Be Fantastic
//
//  Created by Flywheel on 19/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class SeeMoreViewController: UIViewController {

   
    @IBOutlet weak var contentTextView: UITextView!
    var contentString = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTextView.text = contentString

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
