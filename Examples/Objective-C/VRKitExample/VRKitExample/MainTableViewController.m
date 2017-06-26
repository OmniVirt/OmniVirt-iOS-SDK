//
//  MainTableViewController.m
//  VRKitExample
//
//  Created by Kuntee Viriyothai on 4/27/17.
//  Copyright © 2017 Omnivirt. All rights reserved.
//

#import "MainTableViewController.h"
#import "VRKit/VRKit.h"

@interface MainTableViewController () <UITextFieldDelegate, VRPlayerDelegate, VRAdDelegate>
{
    IBOutlet UILabel *modeLabel;
    IBOutlet UITextField *contentIdTextField;
    IBOutlet UITextField *adSpaceIdTextField;
    IBOutlet VRPlayer *player;
    IBOutlet UIButton *submitButton;
    
    VRAd *omnivirtAd;
    BOOL isCardboard;
    int mode;
    BOOL isExpanded;
}
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isCardboard = NO;
    mode = 1;
    isExpanded = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"SELECT MODE TO PRESENT" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"View Player in Fullscreen" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            mode = 1;
            modeLabel.text = action.title;
            [tableView reloadData];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"View Player in Embed" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            mode = 2;
            modeLabel.text = action.title;
            [tableView reloadData];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"View Ad Only" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            mode = 3;
            modeLabel.text = action.title;
            [tableView reloadData];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else if (indexPath.section == 3) {
        [self submit];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (mode == 2 && indexPath.section == 1 && indexPath.row == 1) {
        return 0;
    } else if (mode == 3 && indexPath.section == 1 && indexPath.row == 0) {
        return 0;
    } else if (indexPath.section == 4) {
        if (isExpanded) {
            return [UIScreen mainScreen].bounds.size.height + 1;
        } else {
            return tableView.bounds.size.width;
        }
    } else {
        return tableView.rowHeight;
    }
}

// MARK: - Actions

- (void)startFullscreenPlayer {
    if ([[NSScanner scannerWithString:contentIdTextField.text] scanInt:nil]) {
        uint contentId = [contentIdTextField.text intValue];
        Mode cardboardMode = isCardboard ? ModeOn : ModeOff;
        FullscreenVRPlayer *fsplayer;
        if ([[NSScanner scannerWithString:adSpaceIdTextField.text] scanInt:nil]) {
            uint adSpaceId = [adSpaceIdTextField.text intValue];
            fsplayer = [FullscreenVRPlayer createWithContentID:contentId andAutoplay:YES andCardboardMode:cardboardMode andAdSpaceIDNumber:[NSNumber numberWithInt: adSpaceId]];
        } else {
            fsplayer = [FullscreenVRPlayer createWithContentID:contentId andAutoplay:YES andCardboardMode:cardboardMode];
        }
        fsplayer.delegate = self;
        fsplayer.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:fsplayer animated:YES completion:nil];
    }
}

- (void)startVRPlayer {
    if ([[NSScanner scannerWithString:contentIdTextField.text] scanInt:nil]) {
        uint contentId = [contentIdTextField.text intValue];
        player.delegate = self;
        [player loadWithContentID:contentId];
    }
}

- (void)startAd {
    if ([[NSScanner scannerWithString:adSpaceIdTextField.text] scanInt:nil]) {
        uint adSpaceId = [adSpaceIdTextField.text intValue];
        omnivirtAd = [VRAd createWithAdSpaceID:adSpaceId andViewController:self andListener:self];
        [omnivirtAd load];
    }
}

- (void)submit {
    switch (mode) {
        case 1:
            [self startFullscreenPlayer];
            break;
        case 2:
            [self startVRPlayer];
            break;
        case 3:
            [self startAd];
            break;
        default:
            break;
    }
}

- (IBAction)switchCardboard: (UISwitch *)sender {
    isCardboard = sender.isOn;
    player.cardboard = isCardboard ? ModeOn : ModeOff;
}

// MARK: - TextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

// MARK: - VRPlayer Delegate

- (void)playerLoaded:(VRPlayer *)player withMaximumQuality:(NSInteger)maximum andCurrentQuality:(enum Quality)current andCardboardMode:(enum Mode)m {
    NSLog(@"Loaded maximumQuality: %ld currentQuality: %ld Mode: %@", maximum, current, (m == ModeOn ? @"Cardboard" : @"Normal"));
    self->player.cardboard = isCardboard ? ModeOn : ModeOff;
}

- (void)playerStarted:(VRPlayer *)player {
    NSLog(@"Started");
}

- (void)playerPaused:(VRPlayer *)player {
    NSLog(@"Paused");
}

- (void)playerEnded:(VRPlayer *)player {
    NSLog(@"Ended");
}

- (void)playerSkipped:(VRPlayer *)player {
    NSLog(@"Skipped");
}

- (void)playerDurationChanged:(VRPlayer *)player withValue:(double)value {
    NSLog(@"Duration changed to %f", value);
}

- (void)playerProgressChanged:(VRPlayer *)player withValue:(double)value {
    NSLog(@"Progress changed to %f", value);
}

- (void)playerBufferChanged:(VRPlayer *)player withValue:(double)value {
    NSLog(@"Buffer changed to %f", value);
}

- (void)playerSeekChanged:(VRPlayer *)player withValue:(double)value {
    NSLog(@"Seek changed to %f", value);
}

- (void)playerCardboardChanged:(VRPlayer *)player withMode:(enum Mode)value {
    NSLog(@"Cardboard changed to %ld", value);
}

- (void)playerAudioChanged:(VRPlayer *)player withLevel:(double)value {
    NSLog(@"Audio changed to %f", value);
}

- (void)playerQualityChanged:(VRPlayer *)player withQuality:(enum Quality)value {
    NSLog(@"Quality changed to %ld", value);
}

- (void)playerExpanded:(VRPlayer *)player {
    NSLog(@"Expanded");
    
    isExpanded = YES;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self.tableView reloadData];
    
    self.tableView.scrollEnabled = NO;
    
    CGRect rect = [self.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:4]];
    rect.origin.y -= 0.5;
    [self.tableView scrollRectToVisible:rect animated:NO];

}

- (void)playerCollapsed:(VRPlayer *)player {
    NSLog(@"Collapsed");
    
    isExpanded = NO;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [self.tableView reloadData];
    
    self.tableView.scrollEnabled = YES;
}

- (void)playerLatitudeChanged:(VRPlayer *)player withLatitude:(double)value {
    NSLog(@"Latitude changed to %f", value);
}

- (void)playerLongitudeChanged:(VRPlayer *)player withLongitude:(double)value {
    NSLog(@"Longitude changed to %f", value);
}

- (void)playerSwitched:(VRPlayer *)player withScene:(NSString *)name withHistory:(NSArray<NSString *> *)history {
    NSLog(@"Switched to %@", name);
}

// MARK: - VRAd Delegate

- (void)adStatusChangedWithAd:(VRAd *)withAd andStatus:(enum AdState)status {
    switch (status) {
        case AdStateNone:
            break;
        case AdStateLoading:
            NSLog(@"Ad state is loading");
            [submitButton setTitle: @"Loading Ad" forState: UIControlStateNormal];
            [submitButton setEnabled: NO];
            break;
        case AdStateReady:
            NSLog(@"Ad state is ready");
            [submitButton setTitle: @"Starting Ad" forState: UIControlStateNormal];
            Mode cardboardMode = isCardboard ? ModeOn : ModeOff;
            [omnivirtAd showWithCardboardMode:cardboardMode];
            break;
        case AdStateShowing:
            NSLog(@"Ad state is showing");
            [submitButton setTitle: @"Showing Ad" forState: UIControlStateNormal];
            break;
        case AdStateCompleted:
            NSLog(@"Ad state is completed");
            [submitButton setTitle: @"Submit" forState: UIControlStateNormal];
            [submitButton setEnabled: YES];
            break;
        case AdStateFailed:
            NSLog(@"Ad state is failed");
            [submitButton setTitle: @"Submit" forState: UIControlStateNormal];
            [submitButton setEnabled: YES];
            break;
    }
}

@end
