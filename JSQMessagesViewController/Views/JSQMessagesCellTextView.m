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

#import "JSQMessagesCellTextView.h"

@implementation JSQMessagesCellTextView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textColor = [UIColor whiteColor];
    [self setUserInteractionEnabled:YES];
    self.userInteractionEnabled = YES;
    self.enabledTextCheckingTypes = UIDataDetectorTypeNone;
    self.backgroundColor = [UIColor clearColor];
    self.textInsets = UIEdgeInsetsZero;
    self.numberOfLines = 0;
    self.activeLinkAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    [self removeGestureRecognizer:super.longPressGestureRecognizer];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //  ignore double-tap to prevent copy/define/etc. menu from showing
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gestureRecognizer;
        if (tap.numberOfTapsRequired == 2) {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //  ignore double-tap to prevent copy/define/etc. menu from showing
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gestureRecognizer;
        if (tap.numberOfTapsRequired == 2) {
            return NO;
        }
    }
    
    return YES;
}

- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    // Resets the text with new attributes
    self.text = self.text;
}

- (void)setLinkTextAttributes:(id)attributes {
    self.linkAttributes = attributes;
}

- (UIEdgeInsets)textContainerInset {
    return self.textInsets;
}

- (void)setTextContainerInset:(UIEdgeInsets)textInsets {
    self.textInsets = textInsets;
}

- (BOOL) selectable {
    return self.userInteractionEnabled;
}

- (void) setSelectable:(BOOL *) makeSelectable {
    [self setUserInteractionEnabled:makeSelectable];
}


@end
