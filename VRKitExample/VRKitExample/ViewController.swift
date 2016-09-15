//
//  ViewController.swift
//  VRKitExample
//
//  Created by Jatupon Sukkasem on 9/13/16.
//  Copyright © 2016 Jatupon Sukkasem. All rights reserved.
//

import UIKit
import VRKit

class ViewController: UIViewController, VRPlayerDelegate {

    @IBOutlet weak var player: VRPlayer!
    @IBOutlet weak var log: UITextView!
    @IBOutlet weak var logHeight: NSLayoutConstraint!
    
    var isExpanded: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        player.delegate = self;
        
        // Use this method to disable interface
        //
        // player.interface = Mode.OFF;
        
        player.load(withContentID: 24);
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ViewController.rotate(_:)),
            name: NSNotification.Name.UIDeviceOrientationDidChange,
            object: nil)
    }
    
    func rotate(_ notification: Notification) {
        if (UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
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

    func playerDidLoaded(_ player: VRPlayer, withMaximumQuality maximum:Int, andCurrentQuality current:Quality, andCardboardMode mode:Mode) {
        log.text! += "Loaded maximumQuality: " + String(describing: maximum) + " currentQuality: " + String(describing: current) + "\n"
        
        // Use this method to start playing
        // 
        // player.play()
    }
    func playerDidStarted(_ player: VRPlayer) {
        log.text! += "Started\n"
    }
    func playerDidPaused(_ player: VRPlayer) {
        log.text! += "Paused\n"
    }
    func playerDidEnded(_ player: VRPlayer) {
        log.text! += "Ended\n"
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
    func playerDidExpanded(_ player: VRPlayer) {
        log.text! += "Expanded\n"
        isExpanded = true;
        
        if (UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            logHeight.constant = 0.0
        }
    }
    func playerDidCollapsed(_ player: VRPlayer) {
        log.text! += "Collapsed\n"
        isExpanded = false;
        
        if (UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
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
    func playerDidSwitched(_ player: VRPlayer, withScene name: String) {
        log.text! += "Switched to " + name + "\n"
    }
}

