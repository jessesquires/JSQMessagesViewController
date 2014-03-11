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

@interface JSQDemoViewController : JSQMessagesViewController <JSQMessagesViewControllerDelegate,
                                                              JSQMessagesCollectionViewFlowLayoutDelegate>

@property (strong, nonatomic) NSMutableArray *messages;

@property (copy, nonatomic) NSDictionary *avatars;

@end
