//
//  ViewController.swift
//  VRKitExample
//
//  Created by Jatupon Sukkasem on 9/13/16.
//  Copyright © 2016 Jatupon Sukkasem. All rights reserved.
//

import UIKit
import VRKit

class ViewController: UIViewController, VRPlayerDelegate, VRAdDelegate {
    @IBOutlet weak var player: VRPlayer!
    @IBOutlet weak var log: UITextView!
    @IBOutlet weak var logHeight: NSLayoutConstraint!
    
    var isExpanded: Bool = false;
    var omnivirtAd: VRAd? = nil;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        player.delegate = self;
        
        // Use this method to disable interface
        //
        // player.interface = Mode.OFF;
        
        player.load(withContentID: 20);
        
        // For manually creating VRplayer without storyboard, please uncomment the following code.
        
        /*let _player = VRPlayer.create();
         _player.load(withContentID: 20);
         _player.frame = self.view.frame;
         self.view.addSubview(_player);
         _player.layoutSubviews();*/
        
        // Creating VR Ad instance
        self.omnivirtAd = VRAd.create(withAdSpaceID: 1, andViewController: self, andListener: self);
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.rotate(_:)),
            name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil)
    }
    
    func rotate(_ notification: Notification) {
        if (UIDevice.current.orientation == UIDeviceOrientation.faceUp || UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            if (isExpanded) {
                logHeight.constant = 0.0;
            }
            else {
                logHeight.constant = 380.0;
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var startAdButton: UIButton!
    @IBAction func startAd(_ sender: Any) {
        if (startAdButton.titleLabel?.text == "Load Ad") {
            self.omnivirtAd?.load();
        }
        else if (startAdButton.titleLabel?.text == "Start Ad") {
            // Select the option to turn on / off Cardboard mode for ads
            self.omnivirtAd?.show(withCardboardMode: Mode.OFF);
        }
    }
    
    func adStatusChanged(withAd ad: VRAd, andStatus status: AdState) {
        switch (status) {
        case AdState.NONE:
            break;
        case AdState.LOADING:
            log.text! += "Ad state is loading\n"
            startAdButton.setTitle("Loading Ad", for: UIControlState.normal);
            startAdButton.isEnabled = false;
            break;
        case AdState.READY:
            log.text! += "Ad state is ready\n"
            startAdButton.setTitle("Start Ad", for: UIControlState.normal);
            startAdButton.isEnabled = true;
            break;
        case AdState.SHOWING:
            log.text! += "Ad state is showing\n"
            startAdButton.setTitle("Showing Ad", for: UIControlState.normal);
            startAdButton.isEnabled = false;
            break;
        case AdState.COMPLETED:
            log.text! += "Ad state is completed\n"
            startAdButton.setTitle("Load Ad", for: UIControlState.normal);
            startAdButton.isEnabled = true;
            break;
        case AdState.FAILED:
            log.text! += "Ad state is failed\n"
            startAdButton.setTitle("Load Ad", for: UIControlState.normal);
            startAdButton.isEnabled = true;
            break;
        }
    }
    
    func playerLoaded(_ player: VRPlayer, withMaximumQuality maximum:Int, andCurrentQuality current:Quality, andCardboardMode mode:Mode) {
        log.text! += "Loaded maximumQuality: " + String(describing: maximum) + " currentQuality: " + String(describing: current) + "\n"
        
        // Use this method to start playing
        // 
        // player.play()
    }
    func playerStarted(_ player: VRPlayer) {
        log.text! += "Started\n"
    }
    func playerPaused(_ player: VRPlayer) {
        log.text! += "Paused\n"
    }
    func playerEnded(_ player: VRPlayer) {
        log.text! += "Ended\n"
    }
    func playerSkipped(_ player: VRPlayer) {
        log.text! += "Skipped\n"
    }
    func playerDurationChanged(_ player: VRPlayer, withValue value:Double) {
        // log.text! += "Duration changed to " + String(value) + "\n"
    }
    func playerProgressChanged(_ player: VRPlayer, withValue value:Double) {
        // log.text! += "Progress changed to " + String(value) + "\n"
    }
    func playerBufferChanged(_ player: VRPlayer, withValue value:Double) {
        // log.text! += "Buffer changed to " + String(value) + "\n"
    }
    func playerSeekChanged(_ player: VRPlayer, withValue value:Double) {
        log.text! += "Seek changed to " + String(value) + "\n"
    }
    func playerCardboardChanged(_ player: VRPlayer, withMode value:Mode) {
        log.text! += "Cardboard changed to " + String(describing: value) + "\n"
    }
    func playerAudioChanged(_ player: VRPlayer, withLevel value:Double) {
        log.text! += "Audio changed to " + String(value) + "\n"
    }
    func playerQualityChanged(_ player: VRPlayer, withQuality value:Quality) {
        log.text! += "Quality changed to " + String(describing: value) + "\n"
    }
    func playerExpanded(_ player: VRPlayer) {
        log.text! += "Expanded\n"
        isExpanded = true;
        
        if (UIDevice.current.orientation == UIDeviceOrientation.faceUp || UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            logHeight.constant = 0.0
        }
    }
    func playerCollapsed(_ player: VRPlayer) {
        log.text! += "Collapsed\n"
        isExpanded = false;
        
        if (UIDevice.current.orientation == UIDeviceOrientation.faceUp || UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            logHeight.constant = 380.0
        }
    }
    func playerLatitudeChanged(_ player: VRPlayer, withLatitude value:Double) {
        // log.text! += "Latitude changed to " + String(value) + "\n"
    }
    func playerLongitudeChanged(_ player: VRPlayer, withLongitude value:Double) {
        // log.text! += "Longitude changed to " + String(value) + "\n"
    }
    func playerSwitched(_ player: VRPlayer, withScene name: String, withHistory history: [String]) {
        log.text! += "Switched to " + name + "\n"
    }
}

