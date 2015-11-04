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
    self.editable = NO;
    self.selectable = YES;
    self.userInteractionEnabled = YES;
    self.dataDetectorTypes = UIDataDetectorTypeNone;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.scrollEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    self.contentInset = UIEdgeInsetsZero;
    self.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.contentOffset = CGPointZero;
    self.textContainerInset = UIEdgeInsetsZero;
    self.textContainer.lineFragmentPadding = 0;
    self.linkTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
}

- (void)setSelectedRange:(NSRange)selectedRange
{
    //  attempt to prevent selecting text
    [super setSelectedRange:NSMakeRange(NSNotFound, 0)];
}

- (NSRange)selectedRange
{
    //  attempt to prevent selecting text
    return NSMakeRange(NSNotFound, NSNotFound);
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    //  ignore double-tap to prevent copy/define/etc. menu from showing
//    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
//        UITapGestureRecognizer *tap = (UITapGestureRecognizer *)gestureRecognizer;
//        if (tap.numberOfTapsRequired == 2) {
//            self.selectedTextRange = nil;
//            return NO;
//        }
//    }
//    
//    return YES;
//}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if(self.editable == NO){
        if ([gestureRecognizer isKindOfClass: [UITapGestureRecognizer class] ] && [(UITapGestureRecognizer*) gestureRecognizer numberOfTapsRequired] == 2) {
            if([gestureRecognizer isMemberOfClass:[UITapGestureRecognizer class]]){
                return YES;
            }
            else{
                return NO;
            }
        }
    }
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
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

- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    if([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]] && gestureRecognizer.delaysTouchesEnded)
    {
        [super addGestureRecognizer:gestureRecognizer];
    }
}



@end
