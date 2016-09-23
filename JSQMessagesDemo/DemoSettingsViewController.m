//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "DemoSettingsViewController.h"

#import "NSUserDefaults+DemoSettings.h"


/**
 *  This is for demo/testing purposes only.
 *
 *  This is a terrible idea for a real app.
 */

@implementation DemoSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.extraMessagesSwitch.on = [NSUserDefaults extraMessagesSetting];
    self.longMessageSwitch.on = [NSUserDefaults longMessageSetting];
    self.emptySwitch.on = [NSUserDefaults emptyMessagesSetting];
    self.accessoryButtonSwitch.on = [NSUserDefaults accessoryButtonForMediaMessages];
    
    self.incomingAvatarsSwitch.on = [NSUserDefaults incomingAvatarSetting];
    self.outgoingAvatarsSwitch.on = [NSUserDefaults outgoingAvatarSetting];
    
    self.springySwitch.on = [NSUserDefaults springinessSetting];
}

- (IBAction)didTapSwitch:(UISwitch *)sender
{
    if (sender == self.extraMessagesSwitch) {
        [NSUserDefaults saveExtraMessagesSetting:sender.on];
    }
    else if (sender == self.longMessageSwitch) {
        [NSUserDefaults saveLongMessageSetting:sender.on];
    }
    else if (sender == self.emptySwitch) {
        [NSUserDefaults saveEmptyMessagesSetting:sender.on];
    }
    else if (sender == self.accessoryButtonSwitch) {
        [NSUserDefaults saveAccessoryButtonForMediaMessages:sender.on];
    }
    else if (sender == self.incomingAvatarsSwitch) {
        [NSUserDefaults saveIncomingAvatarSetting:sender.on];
    }
    else if (sender == self.outgoingAvatarsSwitch) {
        [NSUserDefaults saveOutgoingAvatarSetting:sender.on];
    }
    else if (sender == self.springySwitch) {
        [NSUserDefaults saveSpringinessSetting:sender.on];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
