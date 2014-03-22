//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSQMessagesCollectionSupplementaryView.h"


const CGFloat kJSQMessagesCollectionSupplementaryViewHeight = 20.0f;

NSString * const kJSQMessagesCollectionSupplementaryViewKindRowHeader = @"JSQMessagesRowHeader";
NSString * const kJSQMessagesCollectionSupplementaryViewKindRowFooter = @"JSQMessagesRowFooter";


@interface JSQMessagesCollectionSupplementaryView ()

@property (weak, nonatomic) IBOutlet JSQMessagesLabel *label;

@end



@implementation JSQMessagesCollectionSupplementaryView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesCollectionSupplementaryView class])
                          bundle:[NSBundle mainBundle]];
}

+ (NSString *)supplementaryViewReuseIdentifier
{
    return NSStringFromClass([JSQMessagesCollectionSupplementaryView class]);
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor whiteColor];
    
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont boldSystemFontOfSize:12.0f];
    self.label.textColor = [UIColor lightGrayColor];
}

#pragma mark - Collection view cell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.label.text = nil;
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.label.backgroundColor = backgroundColor;
}

@end
