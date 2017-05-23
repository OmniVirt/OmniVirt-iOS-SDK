//
//  MainTableViewController.swift
//  VRKitExample
//
//  Created by Kuntee Viriyothai on 4/27/17.
//  Copyright © 2017 Omnivirt. All rights reserved.
//

import UIKit
import VRKit

class MainTableViewController: UITableViewController, UITextFieldDelegate, VRPlayerDelegate, VRAdDelegate {

    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var contentIdTextField: UITextField!
    @IBOutlet weak var adSpaceIdTextField: UITextField!
    @IBOutlet weak var player: VRPlayer!
    @IBOutlet weak var submitButton: UIButton!
    
    var omnivirtAd: VRAd? = nil
    var isCardboard: Bool = false
    var mode = 1
    var isExpanded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "VRKIT_ENABLE_STAGING")
        userDefaults.synchronize()
    }

    // MARK: - Table view data source & delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            let alertController = UIAlertController(title: "SELECT MODE TO PRESENT", message: nil, preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "View Player in Fullscreen", style: .default, handler: { action in
                self.mode = 1
                self.modeLabel.text = action.title
                tableView.reloadData()
            }))
            alertController.addAction(UIAlertAction(title: "View Player in Embed", style: .default, handler: { action in
                self.mode = 2
                self.modeLabel.text = action.title
                tableView.reloadData()
            }))
            alertController.addAction(UIAlertAction(title: "View Ad Only", style: .default, handler: { action in
                self.mode = 3
                self.modeLabel.text = action.title
                tableView.reloadData()
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            }))
            present(alertController, animated: true, completion: nil)
        } else if indexPath.section == 3 {
            submit()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if mode == 2 && indexPath.section == 1 && indexPath.row == 1 {
            return 0
        } else if mode == 3 && indexPath.section == 1 && indexPath.row == 0 {
            return 0
        } else if indexPath.section == 4 {
            if isExpanded {
                return UIScreen.main.bounds.height + 1
            } else {
                return tableView.bounds.width
            }
        } else {
            return tableView.rowHeight
        }
    }

    // MARK: - Actions
    
    func startFullscreenPlayer() {
        let contentId = uint(contentIdTextField.text!)
        let adSpaceId = uint(adSpaceIdTextField.text!)
        if contentId != nil {
            let cardboardMode: Mode = isCardboard ? .On : .Off;
            let fsplayer = FullscreenVRPlayer.create(withContentID: contentId!, andAutoplay: true, andCardboardMode: cardboardMode, andAdSpaceID: adSpaceId, andDelegate: self)
            fsplayer.modalPresentationStyle = .fullScreen
            self.present(fsplayer, animated: true) {
            }
        }
    }
    
    func startVRPlayer() {
        let contentId = uint(contentIdTextField.text!)
        if contentId != nil {
            player.delegate = self
            player.load(withContentID: contentId!)
        }
    }
    
    func startAd() {
        let adSpaceId = uint(adSpaceIdTextField.text!)
        if adSpaceId != nil {
            omnivirtAd = VRAd.create(withAdSpaceID: adSpaceId!, andViewController: self, andListener: self)
            omnivirtAd?.load()
        }
    }
    
    func submit() {
        switch (mode) {
        case 1:
            startFullscreenPlayer()
            break
        case 2:
            startVRPlayer()
            break
        case 3:
            startAd()
            break
        default:
            break
        }
    }
    
    @IBAction func switchCardboard(sender: UISwitch) {
        isCardboard = sender.isOn
        player.cardboard = isCardboard ? .On : .Off
    }
    
    // MARK: - TextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: - VRPlayer Delegate
    
    func playerLoaded(_ player: VRPlayer, withMaximumQuality maximum:Int, andCurrentQuality current:Quality, andCardboardMode mode:Mode) {
        print("Loaded maximumQuality: " + String(describing: maximum) + " currentQuality: " + String(describing: current) + " Mode: " + (mode == .On ? "Cardboard" : "Normal"))
        player.cardboard = isCardboard ? .On : .Off
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
        
        isExpanded = true
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        tableView.reloadData()
        
        tableView.isScrollEnabled = false
        
        var rect = tableView.rectForRow(at: IndexPath(row: 0, section: 4))
        rect = rect.offsetBy(dx: 0, dy: -0.5)
        tableView.scrollRectToVisible(rect, animated: false)
    }
    
    func playerCollapsed(_ player: VRPlayer) {
        print("Collapsed")
        
        isExpanded = false
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        tableView.reloadData()
        
        tableView.isScrollEnabled = true
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
    
    // MARK: - VRAd Delegate
    
    func adStatusChanged(withAd ad: VRAd, andStatus status: AdState) {
        switch (status) {
        case AdState.None:
            break
        case AdState.Loading:
            print("Ad state is loading")
            submitButton.setTitle("Loading Ad", for: UIControlState.normal)
            submitButton.isEnabled = false
            break
        case AdState.Ready:
            print("Ad state is ready")
            submitButton.setTitle("Starting Ad", for: UIControlState.normal)
            let cardboardMode: Mode = isCardboard ? .On : .Off;
            omnivirtAd?.show(withCardboardMode: cardboardMode)
            break
        case AdState.Showing:
            print("Ad state is showing")
            submitButton.setTitle("Showing Ad", for: UIControlState.normal)
            self.player.idle = Mode.On // Idling any video player to reserve GPU resources for VR Ad
            break
        case AdState.Completed:
            print("Ad state is completed")
            submitButton.setTitle("Submit", for: UIControlState.normal)
            submitButton.isEnabled = true
            self.player.idle = Mode.Off // Resume the video player
            break
        case AdState.Failed:
            print("Ad state is failed")
            submitButton.setTitle("Submit", for: UIControlState.normal)
            submitButton.isEnabled = true
            break
        }
    }
}
