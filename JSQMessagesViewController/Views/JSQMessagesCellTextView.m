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
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappingFired:)];
    _tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:_tapGestureRecognizer];
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
    // Resets the ttt text with new attributes
    self.text = self.text;
}

- (NSDictionary *)linkTextAttributes {
    return self.linkAttributes;
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

- (void) setSelectable:(BOOL) makeSelectable {
    [self setUserInteractionEnabled: makeSelectable];
}

- (void) tappingFired:(UITapGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateEnded: {
            CGPoint touchPoint = [sender locationInView:self];
            NSTextCheckingResult *result = [self linkAtPoint:touchPoint];
            if (result){
                switch (result.resultType) {
                    case NSTextCheckingTypeLink:
                        if([self.delegate respondsToSelector:@selector(attributedLabel:didSelectLinkWithURL:)]) {
                            [self.delegate attributedLabel:self didSelectLinkWithURL:result.URL];
                            return;
                        }
                        break;
                    case NSTextCheckingTypeAddress:
                        if ([self.delegate respondsToSelector:@selector(attributedLabel:didSelectLinkWithAddress:)]) {
                            [self.delegate attributedLabel:self didSelectLinkWithAddress:result.addressComponents];
                            return;
                        }
                        break;
                    case NSTextCheckingTypePhoneNumber:
                        if ([self.delegate respondsToSelector:@selector(attributedLabel:didSelectLinkWithPhoneNumber:)]) {
                            [self.delegate attributedLabel:self didSelectLinkWithPhoneNumber:result.phoneNumber];
                            return;
                        }
                        break;
                    case NSTextCheckingTypeDate:
                        if (result.timeZone && [self.delegate respondsToSelector:@selector(attributedLabel:didSelectLinkWithDate:timeZone:duration:)]) {
                            [self.delegate attributedLabel:self didSelectLinkWithDate:result.date timeZone:result.timeZone duration:result.duration];
                            return;
                        } else if ([self.delegate respondsToSelector:@selector(attributedLabel:didSelectLinkWithDate:)]) {
                            [self.delegate attributedLabel:self didSelectLinkWithDate:result.date];
                            return;
                        }
                        break;
                    case NSTextCheckingTypeTransitInformation:
                        if ([self.delegate respondsToSelector:@selector(attributedLabel:didSelectLinkWithTransitInformation:)]) {
                            [self.delegate attributedLabel:self didSelectLinkWithTransitInformation:result.components];
                            return;
                        }
                    default:
                        break;
                }
                if ([self.delegate respondsToSelector:@selector(attributedLabel:didSelectLinkWithTextCheckingResult:)]){
                    [self.delegate attributedLabel:self didSelectLinkWithTextCheckingResult:result];
                }
            }
            break;
        }
        default:
            break;
    }
}

@end
