//
//  MoreDetailViewController.swift
//  Be Fantastic
//
//  Created by Flywheel on 09/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import WebKit

class MoreDetailViewController: UIViewController {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailWebView: WKWebView!
    var detailText = ""
    var LinkUrl  = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailLabel.text = detailText
        
        let url = URL(string: LinkUrl)
        let request = URLRequest(url: url!)
        detailWebView.load(request)

        // Do any additional setup after loading the view.
    }
    

    @IBAction func BackButton(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

}
