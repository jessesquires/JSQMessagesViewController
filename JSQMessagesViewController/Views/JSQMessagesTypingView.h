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

#import <UIKit/UIKit.h>

// TODO: write documentation
//
// https://github.com/jessesquires/JSQMessagesViewController/issues/1647
//

NS_ASSUME_NONNULL_BEGIN

@interface JSQMessagesTypingView : UIView

@property (strong, nonatomic) UIColor *dotsColor;

@property (strong, nonatomic) UIColor *animateToColor;

@property (assign, nonatomic) CGFloat animationDuration;

@property (assign, nonatomic) BOOL animated;

@end

NS_ASSUME_NONNULL_END
