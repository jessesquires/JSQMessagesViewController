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

#import "JSDemoViewController.h"

#define kSubtitleJobs @"Jobs"
#define kSubtitleWoz @"Steve Wozniak"
#define kSubtitleCook @"Mr. Cook"

@implementation JSDemoViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.delegate = self;
    self.dataSource = self;
    [super viewDidLoad];
    
    [[JSBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];
    
    self.title = @"Messages";
    
    self.messageInputView.textView.placeHolder = @"New Message";
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     @"JSMessagesViewController is simple and easy to use.",
                     @"It's highly customizable.",
                     @"Including custom subtitle and timestamp display policies.",
                     @"It even has data detectors. You can call me tonight. My cell number is 452-123-4567. \nMy website is www.hexedbits.com.",
                     @"Group chat is possible. Sound effects and images included. Animations are smooth. Messages can be of arbitrary size!",
                     nil];
    
    self.timestamps = [[NSMutableArray alloc] initWithObjects:
                       [NSDate dateWithTimeInterval:-300 sinceDate:[NSDate date]],
                       [NSDate dateWithTimeInterval:-240 sinceDate:[NSDate date]],
                       [NSDate dateWithTimeInterval:-180 sinceDate:[NSDate date]],
                       [NSDate dateWithTimeInterval:-59 sinceDate:[NSDate date]],
                       [NSDate date],
                       nil];
    
    self.subtitles = [[NSMutableArray alloc] initWithObjects:
                      kSubtitleJobs,
                      kSubtitleWoz,
                      kSubtitleWoz,
                      kSubtitleJobs,
                      kSubtitleCook, nil];
    
    self.avatars = [[NSDictionary alloc] initWithObjectsAndKeys:
                    [JSAvatarImageFactory avatarImageNamed:@"demo-avatar-jobs" croppedToCircle:YES], kSubtitleJobs,
                    [JSAvatarImageFactory avatarImageNamed:@"demo-avatar-woz" croppedToCircle:YES], kSubtitleWoz,
                    [JSAvatarImageFactory avatarImageNamed:@"demo-avatar-cook" croppedToCircle:YES], kSubtitleCook,
                    nil];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
//                                                                                           target:self
//                                                                                           action:@selector(buttonPressed:)];
}

- (void)buttonPressed:(UIButton *)sender
{
    // Testing pushing/popping messages view
    JSDemoViewController *vc = [[JSDemoViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

#pragma mark - Messages view delegate: REQUIRED

- (void)didSendText:(NSString *)text
{
    [self.messages addObject:text];
    
    [self.timestamps addObject:[NSDate date]];
    
    if((self.messages.count - 1) % 2) {
        [JSMessageSoundEffect playMessageSentSound];
        
        [self.subtitles addObject:arc4random_uniform(100) % 2 ? kSubtitleCook : kSubtitleWoz];
    }
    else {
        [JSMessageSoundEffect playMessageReceivedSound];
        
        [self.subtitles addObject:kSubtitleJobs];
    }
    
    [self finishSend];
    [self scrollToBottomAnimated:YES];
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([[self.subtitles objectAtIndex:indexPath.row] isEqualToString:kSubtitleWoz]) ? JSBubbleMessageTypeIncoming : JSBubbleMessageTypeOutgoing;
}

- (UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type
                       forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.subtitles objectAtIndex:indexPath.row] isEqualToString:kSubtitleWoz]) {
        return [JSBubbleImageViewFactory bubbleImageViewForType:type
                                                          color:[UIColor js_bubbleLightGrayColor]];
    }
    
    return [JSBubbleImageViewFactory bubbleImageViewForType:type
                                                      color:[UIColor js_bubbleBlueColor]];
}

- (JSMessagesViewTimestampPolicy)timestampPolicy
{
    return JSMessagesViewTimestampPolicyCustom;
}

- (JSMessagesViewAvatarPolicy)avatarPolicy
{
    return JSMessagesViewAvatarPolicyAll;
}

- (JSMessagesViewSubtitlePolicy)subtitlePolicy
{
    return JSMessagesViewSubtitlePolicyCustom;
}

- (JSMessageInputViewStyle)inputViewStyle
{
    return JSMessageInputViewStyleFlat;
}

#pragma mark - Messages view delegate: OPTIONAL

//
//  *** Implement to customize cell further
//
- (void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    if([cell messageType] == JSBubbleMessageTypeOutgoing) {
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
    
        if([cell.bubbleView.textView respondsToSelector:@selector(linkTextAttributes)]) {
            NSMutableDictionary *attrs = [cell.bubbleView.textView.linkTextAttributes mutableCopy];
            [attrs setValue:[UIColor blueColor] forKey:UITextAttributeTextColor];
            
            cell.bubbleView.textView.linkTextAttributes = attrs;
        }
    }
    
    if(cell.timestampLabel) {
        cell.timestampLabel.textColor = [UIColor lightGrayColor];
        cell.timestampLabel.shadowOffset = CGSizeZero;
    }
    
    if(cell.subtitleLabel) {
        cell.subtitleLabel.textColor = [UIColor lightGrayColor];
    }
}

//  *** Required if using `JSMessagesViewTimestampPolicyCustom`
//
//  In this example, we only print the timestamp if it's more than 2 minutes
//  since the previous message, or if it's the first message in our display
//
- (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row > 0) {
        if ([self.timestamps[indexPath.row] timeIntervalSinceDate:self.timestamps[indexPath.row-1]] > 120) {
			return YES;
		}
		else {
			return NO;
		}
	}
	else {
        return YES;
	}
}

//  *** Required if using `JSMessagesViewSubtitlePolicyCustom`
//
//  In this example, we only print the subtitle if it differs from the one above
//  it, or if it's the first message in our display.
//
- (BOOL)hasSubtitleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        if (![self.subtitles[indexPath.row] isEqualToString:self.subtitles[indexPath.row-1]]) {
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return YES;
    }
}

//  *** Implement to use a custom send button
//
//  The button's frame is set automatically for you
//
//  - (UIButton *)sendButtonForInputView
//

//  *** Implement to prevent auto-scrolling when message is added
//
- (BOOL)shouldPreventScrollToBottomWhileUserScrolling
{
    return YES;
}

#pragma mark - Messages view data source: REQUIRED

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.row];
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.timestamps objectAtIndex:indexPath.row];
}

- (UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *subtitle = [self.subtitles objectAtIndex:indexPath.row];
    UIImage *image = [self.avatars objectForKey:subtitle];
    return [[UIImageView alloc] initWithImage:image];
}

- (NSString *)subtitleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.subtitles objectAtIndex:indexPath.row];
}

@end
