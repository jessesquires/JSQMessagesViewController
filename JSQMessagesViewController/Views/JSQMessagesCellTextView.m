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
#import "NSString+JSQMessages.h"
#import <CoreText/CoreText.h>

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

    [self addObserver:self
           forKeyPath:@"text"
              options:NSKeyValueObservingOptionNew
              context:nil];
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


-(void) observeValueForKeyPath:(NSString *) keyPath
                      ofObject:(id) object
                        change:(NSDictionary *) change
                       context:(void *) context
{
    if ([keyPath isEqualToString:@"text"]) {
        [self highlightMentions];
        [self highlightHashTags];
    }
}


-(void) highlightMentions
{
    if (self.text) {
        NSMutableAttributedString *attributedString = self.attributedText ? [self.attributedText mutableCopy] : [[NSMutableAttributedString alloc] initWithString:self.text];

        NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:@"(^| )@[a-z0-9._-]+"
                                                                                      options:NSRegularExpressionCaseInsensitive
                                                                                        error:nil];
        [regularExpression enumerateMatchesInString:self.text
                                            options:NSMatchingReportCompletion
                                              range:NSMakeRange(0, self.text.length)
                                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                             if (result) {
                                                 NSRange range = result.range;
                                                 range.location += range.location ? 1 : 0;
                                                 range.length -= range.location ? 1 : 0;

                                                 NSString *username = [[self.text substringWithRange:result.range] jsq_stringByTrimingWhitespace];

                                                 [attributedString addAttribute:NSLinkAttributeName
                                                                          value:[NSString stringWithFormat:@"username://%@", username]
                                                                          range:range];

                                                 [attributedString addAttribute:NSForegroundColorAttributeName
                                                                          value:[UIColor greenColor]
                                                                          range:result.range];
                                                 [attributedString addAttribute:((__bridge NSString *)kCTForegroundColorAttributeName)
                                                                          value:(id)[UIColor greenColor].CGColor
                                                                          range:result.range];

                                                 [attributedString addAttribute:NSUnderlineStyleAttributeName
                                                                          value:@(NSUnderlineStyleNone)
                                                                          range:result.range];
                                             }
                                         }];

        self.attributedText = attributedString;
    }
}

-(void) highlightHashTags
{
    if (self.text) {
        NSMutableAttributedString *attributedString = self.attributedText ? [self.attributedText mutableCopy] : [[NSMutableAttributedString alloc] initWithString:self.text];

        NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:@"#\\w+"
                                                                                      options:NSRegularExpressionCaseInsensitive
                                                                                        error:nil];
        [regularExpression enumerateMatchesInString:self.text
                                            options:NSMatchingReportCompletion
                                              range:NSMakeRange(0, self.text.length)
                                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                             if (result) {
                                                 NSRange range = result.range;
                                                 range.location += 1;
                                                 range.length -= 1;

                                                 [attributedString addAttribute:NSLinkAttributeName
                                                                          value:[NSString stringWithFormat:@"hashtag://%@", [self.text substringWithRange:range]]
                                                                          range:result.range];
                                                 
                                                 [attributedString addAttribute:NSForegroundColorAttributeName
                                                                          value:[UIColor greenColor]
                                                                          range:result.range];
                                             }
                                         }];

        self.attributedText = attributedString;
    }
}

-(void)dealloc
{
    [self removeObserver:self
              forKeyPath:@"text"];
}

@end
