//
//  JSQMessagesEditCollectionOverlayView.m
//  Pods
//
//  Created by Aleksei Shevchenko on 5/22/16.
//
//

#import "JSQMessagesEditCollectionOverlayView.h"
#import "UIImage+JSQMessages.h"
#import "JSQMessagesCollectionViewLayoutAttributes.h"
#import "UIColor+JSQMessages.h"

@interface JSQMessagesEditCollectionOverlayView()
@property (nonatomic, strong) IBOutlet UIImageView *leftIconView;
@property (nonatomic, strong) IBOutlet UIImageView *rightIconView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *leftIconLeadingConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *rightIconLeadingConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *leftIconVerticalCenterConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *rightIconVerticalCenterConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *leftIconWidthConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *rightIconWidthConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *leftIconHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *rightIconHeightConstraint;

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@end

const CGFloat kJSQMessagesEditCollectionOverlayViewIconHeight = 22.0;


@implementation JSQMessagesEditCollectionOverlayView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesEditCollectionOverlayView class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesEditCollectionOverlayView class]]];
}

+ (NSString *)editingReuseIdentifier
{
    return NSStringFromClass([JSQMessagesEditCollectionOverlayView class]);
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor clearColor];
    
    UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOverlayButton:)];
    [self addGestureRecognizer:tapRecognizer];
    self.userInteractionEnabled = YES;
    
    if(!_activeColor) {
        _activeColor = [UIColor jsq_messageBubbleBlueColor];
    }
    if(!_inactiveColor) {
        _inactiveColor = [UIColor jsq_messageBubbleLightGrayColor];
    }
}

#pragma mark - Reusable view

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.leftIconView.backgroundColor = backgroundColor;
    self.rightIconView.backgroundColor = backgroundColor;

}


#pragma mark - Editing

- (void)configureDisplayingOnLeft:(BOOL)shouldDisplayOnLeft
                         isActive:(BOOL)isActive
                forCollectionView:(UICollectionView *)collectionView;
{
    self.leftIconView.hidden = !shouldDisplayOnLeft;
    self.rightIconView.hidden = shouldDisplayOnLeft;
    self.isActive = isActive;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    JSQMessagesCollectionViewLayoutAttributes *customAttributes = (JSQMessagesCollectionViewLayoutAttributes *)layoutAttributes;
    
    CGFloat bubbleTop = customAttributes.cellTopLabelHeight + customAttributes.messageBubbleTopLabelHeight;
    
    CGFloat bubbleCenter = bubbleTop + customAttributes.messageBubbleContainerViewHeight/2.0;
    
    self.leftIconVerticalCenterConstraint.constant = bubbleCenter - CGRectGetHeight(customAttributes.frame)/2.0;
    
    self.rightIconVerticalCenterConstraint.constant = self.leftIconVerticalCenterConstraint.constant;
    
    [self setNeedsUpdateConstraints];
}

-(void)setIsActive:(BOOL)isActive
{
    _isActive = isActive;
    if(isActive) {
        self.leftIconView.image = [[UIImage jsq_defaultEditingActiveImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.rightIconView.image = self.leftIconView.image;
        
        self.leftIconView.tintColor = self.activeColor;
        self.rightIconView.tintColor = self.activeColor;
    }
    else {
        self.leftIconView.image = [[UIImage jsq_defaultEditingInactiveImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.rightIconView.image = self.leftIconView.image;
        
        self.leftIconView.tintColor = self.inactiveColor;
        self.rightIconView.tintColor = self.inactiveColor;
    }
}


#pragma mark - UI callbacks

-(IBAction)onTapOverlayButton:(id)sender
{
    self.isActive = !self.isActive;
    [self.delegate editOverlayView:self activated:self.isActive];
}
@end
