//
//  JSQMessagesTypingView.h
//  JSQMessages
//
//  Created by Radek Cieciwa on 30.05.2016.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSQMessagesTypingView : UIView
@property(nonatomic) UIColor *dotsColor;
@property(nonatomic) UIColor *animateToColor;
@property(nonatomic) CGFloat animationDuration;
@property(nonatomic) BOOL animated;
@end
