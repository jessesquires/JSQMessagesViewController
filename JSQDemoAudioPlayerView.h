//
//  Created by Vincent Sit
//  http://www.hexedbits.com
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

@class JSQMessage;

@interface JSQDemoAudioPlayerView : UIView

@property (strong, nonatomic) JSQMessage *message;
@property (assign, nonatomic) BOOL incomingMessage;

- (void)startAnimation;
- (void)stopAnimation;
- (BOOL)isAnimating;

@end
