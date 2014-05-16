//
//  JSQMessagesCollectionViewTextCell.m
//  JSQMessages
//
//  Created by Adam Cumiskey on 5/16/14.
//  Copyright (c) 2014 Hexed Bits. All rights reserved.
//

#import "JSQMessagesCollectionViewTextCell.h"
#import "JSQMessagesCollectionViewLayoutAttributes.h"

@interface JSQMessagesCollectionViewTextCell ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation JSQMessagesCollectionViewTextCell

#pragma mark - Class methods

+ (UINib *)nib
{
    NSAssert(NO, @"ERROR: method must be overridden in subclasses: %s", __PRETTY_FUNCTION__);
    return nil;
}

+ (NSString *)cellReuseIdentifier
{
    NSAssert(NO, @"ERROR: method must be overridden in subclasses: %s", __PRETTY_FUNCTION__);
    return nil;
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.textView.textColor = [UIColor whiteColor];
    self.textView.editable = NO;
    self.textView.selectable = YES;
    self.textView.userInteractionEnabled = YES;
    self.textView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.textView.showsHorizontalScrollIndicator = NO;
    self.textView.showsVerticalScrollIndicator = NO;
    self.textView.scrollEnabled = NO;
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.contentInset = UIEdgeInsetsZero;
    self.textView.scrollIndicatorInsets = UIEdgeInsetsZero;
    self.textView.contentOffset = CGPointZero;
    self.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : [UIColor whiteColor],
                                          NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
}

#pragma mark - Collection view cell

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.cellTopLabel.text = nil;
    self.messageBubbleTopLabel.text = nil;
    self.cellBottomLabel.text = nil;
    
    self.textView.text = nil;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    JSQMessagesCollectionViewLayoutAttributes *customAttributes = (JSQMessagesCollectionViewLayoutAttributes *)layoutAttributes;
    
    self.textView.font = customAttributes.messageBubbleFont;
    self.textView.textContainerInset = customAttributes.textViewTextContainerInsets;
    
    [self setNeedsUpdateConstraints];
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)becomeFirstResponder
{
    return [super becomeFirstResponder];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return (action == @selector(copy:));
}

- (void)copy:(id)sender
{
    [[UIPasteboard generalPasteboard] setString:self.textView.text];
    [self resignFirstResponder];
}

@end
