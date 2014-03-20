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
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

@class JSBubbleMessageCell;

@protocol JSMessageTableViewDelegate <NSObject>

@required

@optional

- (void)deleteMessageCell:(JSBubbleMessageCell *)cell;

@end
/**
 *  An instance of `JSMessageTableView` is a subclass of `UITableView` and is means for displaying a list of messages between a group of users.
 */

@interface JSMessageTableView : UITableView
{
    
}

@property (nonatomic, assign) id <JSMessageTableViewDelegate> messageDelegate;

@end
