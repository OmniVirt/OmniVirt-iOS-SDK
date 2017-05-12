# Virtual Reality Embed Player and Monetization for iOS Apps

You can use OmniVirt technology for
- VR App: [Create VR ad space and earn revenues using your in-house VR campaigns or OmniVirt sourced demands](#create-vr-ad-space-and-run-your-ad-campaigns)
- VR App: [Embed your VR content into your app](#embed-your-vr-content-into-your-app)
- Promote your VR campaigns to gain viewerships across OmniVirt Network and the web.

Contact us for more info at [contact@omnivirt.com](mailto:contact@omnivirt.com).
Visit [OmniVirt Website](https://www.omnivirt.com/) to upload content and create ad space.


# Embed your VR content into your app

1. Clone iOS VR example project into your machine. 
   <pre>
   git clone https://github.com/OmniVirt/iOS-VR-Example
   </pre>
2. Open iOS *VRKitExample/VRKitExample.xcodeproj* project using XCode
3. Build and run

## More example

- [Swift VR Player / Monetization](https://github.com/OmniVirt/iOS-VR-Example/tree/master/Examples/Swift/VRKitExample)
- [Objective-C VR Player / Monetization](https://github.com/OmniVirt/iOS-VR-Example/tree/master/Examples/Objective%20C/VRKitExample)
- [Cardboard QR Code Reader](https://github.com/OmniVirt/iOS-VR-Example/tree/master/Examples/Scan%20QR%20Code/VRKitExample)


## Upload and test your VR content

Please upload your VR/360-degree photo or video at [OmniVirt](https://www.omnivirt.com/).
Once you have your content ID, please insert it as part of player.load's parameter.

   <pre>
   player.load(withContentID: 24); // Replace 24 into your Content ID.
   </pre>
## Tutorial - Let's embed your content into your controller

VRKitExample project mainly consists of VRKit.framework and ViewController code.
The program is very simple and coded in very straightforward way.
This tutorial shows you how to make fullscreen cardboard app within minutes.

Inside ViewController, you will find View created under "Player" named with VRPlayer class. **If you plan to use VRPlayer in both landscape and portrait orientation, please make sure to set your controller to allows both orientation**. Gyroscope may not give proper value if device orientation is not supported and the phone is rotated.

![alt tag](https://s3.amazonaws.com/adsoptimal-3dx-assets/manual_upload/wiki/step+1+-+Check+VRPlayer+View.png)

Try making this VRPlayer stretching into fullscreen by adding Vertical constraint with zero value.

![alt tag](https://s3.amazonaws.com/adsoptimal-3dx-assets/manual_upload/wiki/step+2+-+Make+Player+fullscreen.png)

Replace your OmniVirt content ID and insert "player.cardboard = Mode.ON;" inside playerLoaded function.

![alt tag](https://s3.amazonaws.com/adsoptimal-3dx-assets/manual_upload/wiki/step+3+-+Turn+cardboard+mode+on.png)

## Output

![alt tag](https://s3.amazonaws.com/adsoptimal-3dx-assets/manual_upload/wiki/cardboard+output.png)

## Create VR player without storyboard.

You can create the embed player without a Storyboard by using below codes.

   <pre>
   let _player = VRPlayer.create();
   _player.load(withContentID: 24); // Replace 24 with your Content ID
   _player.frame = self.view.frame;
   self.view.addSubview(_player);
   _player.layoutSubviews();
   </pre>

# Create VR ad space and run your ad campaigns

   Sell your own campaigns and dynamically insert campaign with no hard-coding/development work required into your app.
   Backfill your inventory with premium CPM experiences from OmniVirt’s network of advertisers. We support both 360° and 2D video ads inside VR apps.

   Please sign up for OmniVirt account to create Ad Space and replace your Ad Space ID below.

   <pre>
   var omnivirtAd: VRAd? = nil;
   override func viewDidLoad() {
     ...
     // Initialization: Replace 1 with your Ad Space ID.
     self.omnivirtAd = VRAd.create(withAdSpaceID: 1, andViewController: self, andListener: self);
     ...
   }
   @IBAction func startAd(_ sender: Any) {
     ...
     if (startAdButton.titleLabel?.text == "Load Ad") {
       // Loading: Use this method to request the ad.
       self.omnivirtAd?.load();
     }
     ...
     ...
     if (startAdButton.titleLabel?.text == "Start Ad") {
       // Show ad: Once the ad is ready, use this method to display it.
       self.omnivirtAd?.show(withCardboardMode: Mode.OFF);
     }
     ...
   }
   // Use this method to listen if the ad is in loading, ready, showing, completed, or failed status.
   func adStatusChanged(withAd ad: VRAd, andStatus status: AdState) {
     switch (status) {
       case AdState.NONE:
         break;
       case AdState.LOADING:
         ...
       case AdState.READY:
         // Set the button into ready status. So, we can launch the ad space.
         startAdButton.setTitle("Start Ad", for: UIControlState.normal);
         ...
       case AdState.SHOWING:
         ...
       case AdState.COMPLETED:
         ...
       case AdState.FAILED:
         ...
     }
   }
   </pre>

# About OmniVirt

OmniVirt hosts and distributes VR/360 content cross-platform.
With one upload, your virtual reality content can be displayed in any platforms and formats.
To learn more about all OmniVirt services, please visit our [website](https://www.omnivirt.com).

# Questions?

Please email us at [contact@omnivirt.com](mailto:contact@omnivirt.com)
