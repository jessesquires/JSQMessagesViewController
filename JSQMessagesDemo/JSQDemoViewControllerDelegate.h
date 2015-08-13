//
//  JSQDemoViewControllerDelegate.h
//  JSQMessages
//
//  Created by Raphaël Bellec on 13/08/2015.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#ifndef JSQMessages_JSQDemoViewControllerDelegate_h
#define JSQMessages_JSQDemoViewControllerDelegate_h

@class DemoMessagesViewController;

@protocol JSQDemoViewControllerDelegate <NSObject>

- (void)didDismissJSQDemoViewController:(DemoMessagesViewController *)vc;

@end

#endif
