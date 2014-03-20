//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSQMessagesViewController.h"

@class JSQDemoViewController;


@protocol JSQDemoViewControllerDelegate <NSObject>

- (void)didDismissJSQDemoViewController:(JSQDemoViewController *)vc;

@end




@interface JSQDemoViewController : JSQMessagesViewController <JSQMessagesViewControllerDelegate>

@property (weak, nonatomic) id<JSQDemoViewControllerDelegate> delegateModal;

@property (strong, nonatomic) NSMutableArray *messages;

@property (copy, nonatomic) NSDictionary *avatars;

@end
