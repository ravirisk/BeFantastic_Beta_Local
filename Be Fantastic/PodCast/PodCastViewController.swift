//
//  PodCastViewController.swift
//  Be Fantastic
//
//  Created by Ravi on 27/09/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import WebKit
class PodCastViewController: UIViewController {

    @IBOutlet weak var webViewHeigthConstraint: NSLayoutConstraint!
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        let loadHtml = """
// <a class="spreaker-player" href="https://www.spreaker.com/show/dr-fantastics-show" data-resource="show_id=3102930" data-theme="light" data-autoplay="false" data-playlist="show" data-cover="https://d3wo5wojvuv7l.cloudfront.net/images.spreaker.com/original/1022f710846a97671679939e24fdec8a.jpg" data-width="100%" data-height="1400px">Listen to "Dr. Fantastic Interviews" on Spreaker.</a><script async src="https://widget.spreaker.com/widgets.js"></script>
//"""
       
      //  webView.navigationDelegate = self
         
          let loadHtml = """
      <a class="spreaker-player" href="https://www.spreaker.com/show/dr-fantastics-show" data-resource="show_id=3102930" data-theme="light" data-autoplay="false" data-playlist="show" data-cover="https://d3wo5wojvuv7l.cloudfront.net/images.spreaker.com/original/1022f710846a97671679939e24fdec8a.jpg" data-width="100%" data-height="1800px">Listen to "Dr. Fantastic Interviews" on Spreaker.</a><script async src="https://widget.spreaker.com/widgets.js"></script>
        
      """
      
        webView.loadHTMLString(loadHtml, baseURL: nil)
        webView.scrollView.isScrollEnabled=false;
       // myWebViewHeightConstraint.constant = webView.scrollView.contentSize.height
      
        
        
    }

}

extension PodCastViewController:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
        self.webViewHeigthConstraint.constant = height as! CGFloat
        })
        
    }
}
