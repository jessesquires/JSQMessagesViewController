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

#import "JSQMessagesComposerTextView.h"

#import <QuartzCore/QuartzCore.h>

#import "NSString+JSQMessages.h"

@interface JSQMessagesComposerTextView ()

@property (nonatomic, weak) NSLayoutConstraint *heightConstraint;
@property (nonatomic, weak) NSLayoutConstraint *minHeightConstraint;
@property (nonatomic, weak) NSLayoutConstraint *maxHeightConstraint;

@end

@implementation JSQMessagesComposerTextView

#pragma mark - Initialization

- (void)jsq_configureTextView
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    CGFloat cornerRadius = 6.0f;

    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius = cornerRadius;

    self.scrollIndicatorInsets = UIEdgeInsetsMake(cornerRadius, 0.0f, cornerRadius, 0.0f);

    self.textContainerInset = UIEdgeInsetsMake(4.0f, 2.0f, 4.0f, 2.0f);
    self.contentInset = UIEdgeInsetsMake(1.0f, 0.0f, 1.0f, 0.0f);

    self.scrollEnabled = YES;
    self.scrollsToTop = NO;
    self.userInteractionEnabled = YES;

    self.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.textColor = [UIColor blackColor];
    self.textAlignment = NSTextAlignmentNatural;

    self.contentMode = UIViewContentModeRedraw;
    self.dataDetectorTypes = UIDataDetectorTypeNone;
    self.keyboardAppearance = UIKeyboardAppearanceDefault;
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeyDefault;

    self.text = nil;

    _placeHolder = nil;
    _placeHolderTextColor = [UIColor lightGrayColor];

    [self associateConstraints];

    [self jsq_addTextViewNotificationObservers];
}

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer
{
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self jsq_configureTextView];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self jsq_configureTextView];
}

- (void)dealloc
{
    [self jsq_removeTextViewNotificationObservers];
}

// TODO: we should just set these from the xib
- (void)associateConstraints
{
    // iterate through all text view's constraints and identify
    // height, max height and min height constraints.

    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {

            if (constraint.relation == NSLayoutRelationEqual) {
                self.heightConstraint = constraint;
            }

            else if (constraint.relation == NSLayoutRelationLessThanOrEqual) {
                self.maxHeightConstraint = constraint;
            }

            else if (constraint.relation == NSLayoutRelationGreaterThanOrEqual) {
                self.minHeightConstraint = constraint;
            }
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // calculate size needed for the text to be visible without scrolling
    CGSize sizeThatFits = [self sizeThatFits:self.frame.size];
    float newHeight = sizeThatFits.height;

    // if there is any minimal height constraint set, make sure we consider that
    if (self.maxHeightConstraint) {
        newHeight = MIN(newHeight, self.maxHeightConstraint.constant);
    }

    // if there is any maximal height constraint set, make sure we consider that
    if (self.minHeightConstraint) {
        newHeight = MAX(newHeight, self.minHeightConstraint.constant);
    }

    // update the height constraint
    self.heightConstraint.constant = newHeight;
}

#pragma mark - Composer text view

- (BOOL)hasText
{
    return ([[self.text jsq_stringByTrimingWhitespace] length] > 0);
}

#pragma mark - Setters

- (void)setPlaceHolder:(NSString *)placeHolder
{
    if ([placeHolder isEqualToString:_placeHolder]) {
        return;
    }

    _placeHolder = [placeHolder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor
{
    if ([placeHolderTextColor isEqual:_placeHolderTextColor]) {
        return;
    }

    _placeHolderTextColor = placeHolderTextColor;
    [self setNeedsDisplay];
}

#pragma mark - UITextView overrides


- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];

    if (self.contentSize.height <= self.bounds.size.height + 1){
        self.contentOffset = CGPointZero; // Fix wrong contentOfset
    }
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    [super setTextAlignment:textAlignment];
    [self setNeedsDisplay];
}

- (void)paste:(id)sender
{
    if (!self.pasteDelegate || [self.pasteDelegate composerTextView:self shouldPasteWithSender:sender]) {
        [super paste:sender];
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    if ([self.text length] == 0 && self.placeHolder) {
        [self.placeHolderTextColor set];

        [self.placeHolder drawInRect:CGRectInset(rect, 7.0f, 5.0f)
                      withAttributes:[self jsq_placeholderTextAttributes]];
    }
}

#pragma mark - Notifications

- (void)jsq_addTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidBeginEditingNotification
                                               object:self];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveTextViewNotification:)
                                                 name:UITextViewTextDidEndEditingNotification
                                               object:self];
}

- (void)jsq_removeTextViewNotificationObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidChangeNotification
                                                  object:self];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidBeginEditingNotification
                                                  object:self];

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:self];
}

- (void)jsq_didReceiveTextViewNotification:(NSNotification *)notification
{
    [self setNeedsDisplay];
}

#pragma mark - Utilities

- (NSDictionary *)jsq_placeholderTextAttributes
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = self.textAlignment;

    return @{ NSFontAttributeName : self.font,
              NSForegroundColorAttributeName : self.placeHolderTextColor,
              NSParagraphStyleAttributeName : paragraphStyle };
}

#pragma mark - UIMenuController

- (BOOL)canBecomeFirstResponder
{
    return [super canBecomeFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [super becomeFirstResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    [UIMenuController sharedMenuController].menuItems = nil;
    return [super canPerformAction:action withSender:sender];
}

@end
