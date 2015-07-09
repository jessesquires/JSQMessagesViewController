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

@implementation JSQMessagesCellTextView {
    BOOL _hasText;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textColor = [UIColor whiteColor];
    self.editable = NO;
    self.selectable = YES;
    self.userInteractionEnabled = YES;
    self.dataDetectorTypes = UIDataDetectorTypeAll;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;

    // This degraded scrolling performance, but it's still unclear as to why.
    // With accurate layout scrolling will not be possible anyway.
    // self.scrollEnabled = NO;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentInset = UIEdgeInsetsZero;
    self.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.contentOffset = CGPointZero;
    self.textContainerInset = UIEdgeInsetsZero;
    self.textContainer.lineFragmentPadding = 0;
    self.linkTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
}

// In prepareForReuse we would set the text to nil,
// and then we would set the text to the correct value.
// This dance takes time, especially with data detectors in place.
// We make sure that the outside can see the correct values and we do layout.
- (void)setText:(NSString *)text
{
    if (text) {
        [super setText:text];
    }
    _hasText = !!text.length;
    [self setNeedsLayout];
}

- (NSString *)text
{
    return (_hasText) ?  [super text] :  nil;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if (attributedText) {
        [super setAttributedText:attributedText];
    }
    _hasText = !!attributedText.length;
    [self setNeedsLayout];
}

- (NSAttributedString *)attributedText
{
    return (_hasText) ? [super attributedText] : nil;
}

- (void)setSelectedRange:(NSRange)selectedRange
{
    //  prevent selecting text
    [super setSelectedRange:NSMakeRange(NSNotFound, 0)];
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

@end
