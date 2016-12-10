# Create VR Cardboard iOS App in 3 Easy Steps

1. Clone iOS VR example project into your machine. 
   <pre>
   git clone https://github.com/OmniVirt/iOS-VR-Example
   </pre>
2. Open iOS *VRKitExample/VRKitExample.xcodeproj* project using XCode
3. Build and run

# Upload and test your VR content

Please upload your VR/360-degree photo or video at [OmniVirt](https://upload.omnivirt.com/).
Once you have your content ID, please insert it as part of player.load's parameter.

   <pre>
   player.load(withContentID: 24);
   </pre>
# Tutorial - Let's make fullscreen cardboard app

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

# About OmniVirt

OmniVirt hosts and distributes VR/360 content cross-platform.
With one upload, your virtual reality content can be displayed in any platforms and formats.
To learn more about all OmniVirt services, please visit our [website](https://www.omnivirt.com).

# Questions?

Please email us at [contact@omnivirt.com](mailto:contact@omnivirt.com)
