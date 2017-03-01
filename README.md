# Virtual Reality Advertising and Embed Player for iOS Apps



# Embed your VR content into iOS app

1. Clone iOS VR example project into your machine. 
   <pre>
   git clone https://github.com/OmniVirt/iOS-VR-Example
   </pre>
2. Open iOS *VRKitExample/VRKitExample.xcodeproj* project using XCode
3. Build and run

# Upload and test your VR content

Please upload your VR/360-degree photo or video at [OmniVirt](https://www.omnivirt.com/).
Once you have your content ID, please insert it as part of player.load's parameter.

   <pre>
   player.load(withContentID: 24); // Replace 24 into your Content ID.
   </pre>
# Tutorial - Let's embed your content into your app

VRKitExample project mainly consists of VRKit.framework and ViewController code.
The program is very simple and coded in very straightforward way.
This tutorial shows you how to make fullscreen cardboard app within minutes.

Inside ViewController, you will find View created under "Player" named with VRPlayer class.

![alt tag](https://s3.amazonaws.com/adsoptimal-3dx-assets/manual_upload/wiki/step+1+-+Check+VRPlayer+View.png)

Try making this VRPlayer stretching into fullscreen by adding Vertical constraint with zero value.

![alt tag](https://s3.amazonaws.com/adsoptimal-3dx-assets/manual_upload/wiki/step+2+-+Make+Player+fullscreen.png)

Replace your OmniVirt content ID and insert "player.cardboard = Mode.ON;" inside playerLoaded function.

![alt tag](https://s3.amazonaws.com/adsoptimal-3dx-assets/manual_upload/wiki/step+3+-+Turn+cardboard+mode+on.png)

# Output

![alt tag](https://s3.amazonaws.com/adsoptimal-3dx-assets/manual_upload/wiki/cardboard+output.png)

# Alternatively, you can create the embed player without using Storyboard by using below codes.

   <pre>
   let _player = VRPlayer.create();
   _player.load(withContentID: 24); // Replace 24 with your Content ID
   _player.frame = self.view.frame;
   self.view.addSubview(_player);
   _player.layoutSubviews();
   </pre>

# Create VR ad space and run your ad campaigns

   Sell your own campaigns and dynamically insert campaign with no hard-coding/development work required into your app.
   Backfill your inventory with premium CPM experiences from OmniVirt’s network of advertisers.
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
