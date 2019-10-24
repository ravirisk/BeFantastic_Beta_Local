//
//  SettingViewController.swift
//  Be Fantastic
//
//  Created by Flywheel on 23/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    let optionArray = ["About us","Terms and Conditions","Privacy Policy"]
    let imageArray =  ["Aboutus","Terms","Privacy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingTableView.dataSource = self
        self.settingTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension SettingViewController:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTabTableCellTableViewCell", for:indexPath) as! MoreTabTableCellTableViewCell
        cell.moretitleLabel.text = optionArray[indexPath.row]
        cell.moreImageView.image = UIImage(named: imageArray[indexPath.row])
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(red: 148/255, green: 141/255, blue:94/255, alpha: 1.0)
        cell.selectedBackgroundView = selectedView
        
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
         if indexPath.row == 0 {
            if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MoreDetailViewController") as? MoreDetailViewController {
                print("video play")
                vc.detailText = optionArray[indexPath.row]
                vc.LinkUrl = "https://befantastictoday.com/about-us/"
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if indexPath.row == 1 {
            if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MoreDetailViewController") as? MoreDetailViewController {
                print("video play")
                vc.detailText = optionArray[indexPath.row]
                vc.LinkUrl = "https://befantastictoday.com/terms-conditions/"
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else if indexPath.row == 2 {
            if  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MoreDetailViewController") as? MoreDetailViewController {
                print("video play")
                vc.detailText = optionArray[indexPath.row]
                vc.LinkUrl = "https://befantastictoday.com/privacy-policy/"
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 59;//Choose your custom row height
    }
    
}
