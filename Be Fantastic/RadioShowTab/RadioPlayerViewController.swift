//
//  RadioPlayerViewController.swift
//  Be Fantastic
//
//  Created by Flywheel on 11/10/19.
//  Copyright © 2019 Qwerty System. All rights reserved.
//

import UIKit
import iOSAudioPlayer
private let kTestTimeInterval = 20.0

class RadioPlayerViewController: UIViewController {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var fastforwardButton: UIButton!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var sliderTimer: Timer?
    var kTestLink = ""
    var comingDict = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 38.0/255, green: 50.0/255, blue: 56.0/255, alpha: 1.0)
        if let title = comingDict["title"] as? String {
            self.titleLabel.text = title
        }
        
        if let imageName = comingDict["Image"] as? String {
            self.thumbnailImageView.image = UIImage(named: imageName)
        }
        self.hideLoadingIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear( animated )
        
        NotificationCenter.default.addObserver(self, selector: #selector(RadioPlayerViewController.episodeLoadedNotification(_:)), name: .mediaLoadProgress, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.removeObserver( self )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Notifications
    
    @objc func episodeLoadedNotification(_ notification: Notification) {
        if let percentage: NSNumber = notification.object as? NSNumber {
            self.statusLabel.text = "\(percentage.intValue)% Loaded"
        }
    }
    
    
    @IBAction func backButton(_ sender: UIButton) {
        if kTestLink == "" {
            self.navigationController?.popViewController(animated: true)
        }else
        {
            let dictionary: Dictionary <String, AnyObject> = SpringboardData.springboardDictionary(title: "Demo Album", artist: "Demo Artist", duration: Int (300.0), listScreenTitle: "Demo List Screen Title", imagePath: Bundle.main.path(forResource: "", ofType: "png")!)
            
            TPGAudioPlayer.sharedInstance().playPauseMediaFile(audioUrl: URL(string: kTestLink)! as NSURL, springboardInfo: dictionary, startTime: 0.0, completion: {(_ , stopTime) -> () in
                self.navigationController?.popViewController(animated: true)
            } )
        }
       
        
    }
    // MARK: Actions
    
    @IBAction func playButtonPressed(_ sender: AnyObject) {
       
        if let audiolink = comingDict["Link"] {
            self.kTestLink = audiolink
            
            let dictionary: Dictionary <String, AnyObject> = SpringboardData.springboardDictionary(title: "Demo Album", artist: "Demo Artist", duration: Int (300.0), listScreenTitle: "Demo List Screen Title", imagePath: Bundle.main.path(forResource: "", ofType: "png")!)
            
            /*
             Start Player
             */
            
            self.showLoadingIndicator()
            
            TPGAudioPlayer.sharedInstance().playPauseMediaFile(audioUrl: URL(string: kTestLink)! as NSURL, springboardInfo: dictionary, startTime: 0.0, completion: {(_ , stopTime) -> () in
                
                self.hideLoadingIndicator()
                self.setupSlider()
                self.updatePlayButton()
            } )
        }
     
    }
    
    @IBAction func rewindButtonPressed(_ sender: AnyObject) {
        TPGAudioPlayer.sharedInstance().skipDirection(skipDirection: SkipDirection.backward, timeInterval: kTestTimeInterval, offset: TPGAudioPlayer.sharedInstance().currentTimeInSeconds)
    }
    
    @IBAction func fastforwardButtonPressed(_ sender: AnyObject) {
        TPGAudioPlayer.sharedInstance().skipDirection(skipDirection: SkipDirection.forward, timeInterval: kTestTimeInterval, offset: TPGAudioPlayer.sharedInstance().currentTimeInSeconds)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if TPGAudioPlayer.sharedInstance().isPlaying {
            TPGAudioPlayer.sharedInstance().seekPlayerToTime(value: Double( sender.value ), completion: {() -> () in
                self.updatePlayButton()
            })
        }
    }
    
    func updatePlayButton() {
        let playPauseImage = (TPGAudioPlayer.sharedInstance().isPlaying ? UIImage(named: "paused") : UIImage(named: "played"))
        
        self.playButton.setImage(playPauseImage, for: UIControl.State())
    }
    
    func setupSlider() {
        self.progressSlider.maximumValue = Float( TPGAudioPlayer.sharedInstance().durationInSeconds )
        self.progressSlider.minimumValue = 0.0
        
        if let _ = self.sliderTimer {
            self.sliderTimer?.invalidate()
        }
        
        self.sliderTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(RadioPlayerViewController.sliderTimerTriggered), userInfo: nil, repeats: true)
        
        self.setupTotalTimeLabel()
    }
    
    @objc func sliderTimerTriggered() {
        let playerCurrentTime = TPGAudioPlayer.sharedInstance().currentTimeInSeconds
        
        self.progressSlider.value = Float( playerCurrentTime )
        
        self.updateCurrentTimeLabel(Float( playerCurrentTime ))
    }
    
    func updateCurrentTimeLabel(_ currentTimeInSeconds: Float) {
        if currentTimeInSeconds.isNaN || currentTimeInSeconds.isInfinite {
            return
        }
        
        currentTimeLabel.text = timeLabelString( Int( currentTimeInSeconds ) )
    }
    
    func setupTotalTimeLabel() {
        let duration = TPGAudioPlayer.sharedInstance().durationInSeconds
        
        if duration.isNaN || duration.isInfinite {
            return
        }
        
        totalTimeLabel.text = timeLabelString( Int (duration) )
    }
    
    func showLoadingIndicator() {
        self.playButton.isHidden = true
        self.loadingIndicator.isHidden = false
        
        self.loadingIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        self.playButton.isHidden = false
        self.loadingIndicator.isHidden = true
        
        self.loadingIndicator.stopAnimating()
    }
    
    func timeLabelString(_ duration: Int) -> String {
        let currentMinutes = Int(duration) / 60
        let currentSeconds = Int(duration) % 60
        
        return currentSeconds < 10 ? "\(currentMinutes):0\(currentSeconds)" : "\(currentMinutes):\(currentSeconds)"
    }

}
