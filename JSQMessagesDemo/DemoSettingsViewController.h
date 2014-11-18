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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  This is for demo/testing purposes only.
 *
 *  This is a terrible idea for a real app.
 */

@interface DemoSettingsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISwitch *extraMessagesSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *longMessageSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *emptySwitch;

@property (weak, nonatomic) IBOutlet UISwitch *incomingAvatarsSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *outgoingAvatarsSwitch;

@property (weak, nonatomic) IBOutlet UISwitch *springySwitch;

@end
