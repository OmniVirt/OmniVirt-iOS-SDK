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
    @IBOutlet weak var log: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startPlayer(_ sender: Any) {
        // If you don't want to use Ads feature.
        // let fsplayer = FullscreenVRPlayer.create(withContentID: 24, andAutoplay: true, andCardboardMode: Mode.On);
        
        // If you have adSpaceID.
        // let fsplayer = FullscreenVRPlayer.create(withContentID: 24, andAutoplay: true, andCardboardMode: Mode.On, andAdSpaceID: 1);
        
        // If you want to bind events using a delegate (adSpaceID can be nil if you don't have adSpaceID).
        let fsplayer = FullscreenVRPlayer.create(withContentID: 24, andAutoplay: true, andCardboardMode: Mode.On, andAdSpaceID: 1, andDelegate: self);
        
        fsplayer.modalPresentationStyle = .fullScreen;
        self.present(fsplayer, animated: true) {
        }
    }
    
    func playerLoaded(_ player: VRPlayer, withMaximumQuality maximum:Int, andCurrentQuality current:Quality, andCardboardMode mode:Mode) {
        log.text! += "Loaded maximumQuality: " + String(describing: maximum) + " currentQuality: " + String(describing: current) + "\n"
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
    }
    func playerCollapsed(_ player: VRPlayer) {
        log.text! += "Collapsed\n"
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

