//
//  MainTableViewController.swift
//  VRKitExample
//
//  Created by Kuntee Viriyothai on 4/27/17.
//  Copyright © 2017 Omnivirt. All rights reserved.
//

import UIKit
import VRKit

class MainTableViewController: UITableViewController, UITextFieldDelegate, VRPlayerDelegate, VRQRScannerViewControllerDelegate {

    @IBOutlet weak var contentIdTextField: UITextField!
    @IBOutlet weak var adSpaceIdTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source & delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            scanQR()
        } else if indexPath.section == 2 {
            startFullscreenPlayer()
        }
    }

    // MARK: - Actions
    
    func scanQR() {
        self.present(VRQRScannerViewController.create(delegate: self), animated: true) {
        }
    }
    
    func startFullscreenPlayer() {
        let contentId = uint(contentIdTextField.text!)
        let adSpaceId = uint(adSpaceIdTextField.text!)
        if contentId != nil {
            let fsplayer = FullscreenVRPlayer.create(withContentID: contentId!, andAutoplay: true, andCardboardMode: .On, andAdSpaceID: adSpaceId, andDelegate: self)
            fsplayer.modalPresentationStyle = .fullScreen
            self.present(fsplayer, animated: true) {
            }
        }
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: - VRPlayer Delegate
    
    func playerLoaded(_ player: VRPlayer, withMaximumQuality maximum:Int, andCurrentQuality current:Quality, andCardboardMode mode:Mode) {
        print("Loaded maximumQuality: " + String(describing: maximum) + " currentQuality: " + String(describing: current) + " Mode: " + (mode == .On ? "Cardboard" : "Normal"))
    }
    
    func playerStarted(_ player: VRPlayer) {
        print("Started")
    }
    
    func playerPaused(_ player: VRPlayer) {
        print("Paused")
    }
    
    func playerEnded(_ player: VRPlayer) {
        print("Ended")
    }
    
    func playerSkipped(_ player: VRPlayer) {
        print("Skipped")
    }
    
    func playerDurationChanged(_ player: VRPlayer, withValue value:Double) {
        print("Duration changed to " + String(value))
    }
    
    func playerProgressChanged(_ player: VRPlayer, withValue value:Double) {
        print("Progress changed to " + String(value))
    }
    
    func playerBufferChanged(_ player: VRPlayer, withValue value:Double) {
        print("Buffer changed to " + String(value))
    }
    
    func playerSeekChanged(_ player: VRPlayer, withValue value:Double) {
        print("Seek changed to " + String(value))
    }
    
    func playerCardboardChanged(_ player: VRPlayer, withMode value:Mode) {
        print("Cardboard changed to " + String(describing: value))
    }
    
    func playerAudioChanged(_ player: VRPlayer, withLevel value:Double) {
        print("Audio changed to " + String(value))
    }
    
    func playerQualityChanged(_ player: VRPlayer, withQuality value:Quality) {
        print("Quality changed to " + String(describing: value))
    }
    
    func playerExpanded(_ player: VRPlayer) {
        print("Expanded")
    }
    
    func playerCollapsed(_ player: VRPlayer) {
        print("Collapsed")
    }
    
    func playerLatitudeChanged(_ player: VRPlayer, withLatitude value:Double) {
        print("Latitude changed to " + String(value))
    }
    
    func playerLongitudeChanged(_ player: VRPlayer, withLongitude value:Double) {
        print("Longitude changed to " + String(value))
    }
    
    func playerSwitched(_ player: VRPlayer, withScene name: String, withHistory history: [String]) {
        print("Switched to " + name)
    }
    
    // MARK: - VRQRScannerViewController Delegate
    
    func qrScannerFinish(scanner: VRQRScannerViewController) {
        print("QR Scanner finish")
        scanner.dismiss(animated: true, completion: nil)
    }
    
    func qrScannerSkip(scanner: VRQRScannerViewController) {
        scanner.dismiss(animated: true, completion: nil)
    }
}
