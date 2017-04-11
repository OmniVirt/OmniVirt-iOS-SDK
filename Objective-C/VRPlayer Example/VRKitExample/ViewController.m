//
//  ViewController.m
//  VRKitExample
//
//  Created by Jatupon Sukkasem on 4/10/17.
//  Copyright © 2017 Jatupon Sukkasem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    bool isExpanded;
    VRAd *omnivirtAd;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    player.delegate = self;
    
    // Use this method to disable interface
    //
    // [player setInterface:ModeOFF];
    
    [player loadWithContentID:20];
    
    // For manually creating VRplayer without storyboard, please uncomment the following code.
    
    /*VRPlayer *_player = [VRPlayer create];
    [_player loadWithContentID: 20];
    _player.frame = self.view.frame;
    [self.view addSubview:_player];
    [_player layoutSubviews];*/
    
    // Creating VR Ad instance
    omnivirtAd = [VRAd createWithAdSpaceID:1 andViewController:self andListener:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(rotate:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)rotate: (NSNotification *)notification {
    if (UIDevice.currentDevice.orientation == UIDeviceOrientationFaceUp || UIDeviceOrientationIsPortrait(UIDevice.currentDevice.orientation)) {
        if (isExpanded) {
            logHeight.constant = 0.0;
        }
        else {
            logHeight.constant = 380.0;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAd: (id)sender {
    if ([startAdButton.titleLabel.text isEqualToString:@"Load Ad"]) {
        [omnivirtAd load];
    }
    else if ([startAdButton.titleLabel.text isEqualToString:@"Start Ad"]) {
        UIAlertController *optionMenu = [UIAlertController alertControllerWithTitle:nil message:@"Please choose Cardboard mode" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *offAction = [UIAlertAction actionWithTitle:@"OFF" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [omnivirtAd showWithCardboardMode: ModeOff];
        }];
        UIAlertAction *onAction = [UIAlertAction actionWithTitle:@"ON" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [omnivirtAd showWithCardboardMode: ModeOn];
        }];
        [optionMenu addAction:onAction];
        [optionMenu addAction:offAction];
        [self presentViewController:optionMenu animated:YES completion:^{
        }];
    }
}

- (void)adStatusChangedWithAd:(VRAd * _Nonnull)withAd andStatus:(enum AdState)andStatus {
    switch(andStatus) {
        case AdStateNone:
            break;
        case AdStateLoading:
            log.text = [log.text stringByAppendingString:@"Ad state is loading\n"];
            [startAdButton setTitle:@"Loading Ad" forState:UIControlStateNormal];
            [startAdButton setEnabled:NO];
            break;
        case AdStateReady:
            log.text = [log.text stringByAppendingString:@"Ad state is ready\n"];
            [startAdButton setTitle:@"Start Ad" forState:UIControlStateNormal];
            [startAdButton setEnabled:YES];
            break;
        case AdStateShowing:
            log.text = [log.text stringByAppendingString:@"Ad state is showing\n"];
            [startAdButton setTitle:@"Showing Ad" forState:UIControlStateNormal];
            [startAdButton setEnabled:NO];
            break;
        case AdStateCompleted:
            log.text = [log.text stringByAppendingString:@"Ad state is completed\n"];
            [startAdButton setTitle:@"Load Ad" forState:UIControlStateNormal];
            [startAdButton setEnabled:YES];
            break;
        case AdStateFailed:
            log.text = [log.text stringByAppendingString:@"Ad state is failed\n"];
            [startAdButton setTitle:@"Load Ad" forState:UIControlStateNormal];
            [startAdButton setEnabled:YES];
            break;
    }
}

- (void)playerLoaded:(VRPlayer * _Nonnull)player withMaximumQuality:(NSInteger)maximum andCurrentQuality:(enum Quality)current andCardboardMode:(enum Mode)mode {
    log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Loaded maximumQuality: %ld currentQuality: %ld\n", (long)maximum, (long)current]];
    
    // Use this method to start playing
    //
    // [player play];
}
- (void)playerStarted:(VRPlayer * _Nonnull)player {
    log.text = [log.text stringByAppendingString:@"Started\n"];
}
- (void)playerPaused:(VRPlayer * _Nonnull)player {
    log.text = [log.text stringByAppendingString:@"Paused\n"];
}
- (void)playerEnded:(VRPlayer * _Nonnull)player {
    log.text = [log.text stringByAppendingString:@"Ended\n"];
}
- (void)playerSkipped:(VRPlayer * _Nonnull)player {
    log.text = [log.text stringByAppendingString:@"Skipped\n"];
}
- (void)playerDurationChanged:(VRPlayer * _Nonnull)player withValue:(double)value {
    //log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Duration changed to %f\n", value]];
}
- (void)playerProgressChanged:(VRPlayer * _Nonnull)player withValue:(double)value {
    //log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Progress changed to %f\n", value]];
}
- (void)playerBufferChanged:(VRPlayer * _Nonnull)player withValue:(double)value {
    //log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Buffer changed to %f\n", value]];
}
- (void)playerSeekChanged:(VRPlayer * _Nonnull)player withValue:(double)value {
    log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Seek changed to %f\n", value]];
}
- (void)playerCardboardChanged:(VRPlayer * _Nonnull)player withMode:(enum Mode)value {
    log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Cardboard changed to %ld\n", (long)value]];
}
- (void)playerAudioChanged:(VRPlayer * _Nonnull)player withLevel:(double)value {
    log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Audio changed to %f\n", value]];
}
- (void)playerQualityChanged:(VRPlayer * _Nonnull)player withQuality:(enum Quality)value {
    log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Quality changed to %ld\n", (long)value]];
}
- (void)playerExpanded:(VRPlayer * _Nonnull)player {
    log.text = [log.text stringByAppendingString:@"Expanded\n"];
    isExpanded = YES;
    
    if (UIDevice.currentDevice.orientation == UIDeviceOrientationFaceUp || UIDeviceOrientationIsPortrait(UIDevice.currentDevice.orientation)) {
        logHeight.constant = 0.0;
    }
}
- (void)playerCollapsed:(VRPlayer * _Nonnull)player {
    log.text = [log.text stringByAppendingString:@"Collapsed\n"];
    isExpanded = NO;
    
    if (UIDevice.currentDevice.orientation == UIDeviceOrientationFaceUp || UIDeviceOrientationIsPortrait(UIDevice.currentDevice.orientation)) {
        logHeight.constant = 380.0;
    }
}
- (void)playerLatitudeChanged:(VRPlayer * _Nonnull)player withLatitude:(double)value {
    //log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Latitude changed to %f\n", value]];
}
- (void)playerLongitudeChanged:(VRPlayer * _Nonnull)player withLongitude:(double)value {
    //log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Longitude changed to %f\n", value]];
}
- (void)playerSwitched:(VRPlayer * _Nonnull)player withScene:(NSString * _Nonnull)name withHistory:(NSArray<NSString *> * _Nonnull)history {
    log.text = [log.text stringByAppendingString:[NSString stringWithFormat:@"Switched to %@\n", name]];
}

@end
