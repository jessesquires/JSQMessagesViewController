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

#import "JSQMessagesCollectionViewCell.h"

#import "JSQMessagesCollectionViewCellIncoming.h"
#import "JSQMessagesCollectionViewCellOutgoing.h"
#import "JSQMessagesCollectionViewLayoutAttributes.h"

#import "UIView+JSQMessages.h"
#import "UIImage+JSQMessages.h"


static NSMutableSet *jsqMessagesCollectionViewCellActions = nil;


@interface JSQMessagesCollectionViewCell ()

@property (weak, nonatomic) IBOutlet JSQMessagesLabel *cellTopLabel;
@property (weak, nonatomic) IBOutlet JSQMessagesLabel *messageBubbleTopLabel;
@property (weak, nonatomic) IBOutlet JSQMessagesLabel *cellBottomLabel;

@property (weak, nonatomic) IBOutlet UIView *messageBubbleContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *messageBubbleImageView;
@property (weak, nonatomic) IBOutlet JSQMessagesCellTextView *textView;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;

@property (weak, nonatomic) IBOutlet UIButton *accessoryButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleContainerWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewTopVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewAvatarHorizontalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginHorizontalSpaceConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTopLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleTopLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellBottomLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewHeightConstraint;

@property (assign, nonatomic) UIEdgeInsets textViewFrameInsets;

@property (assign, nonatomic) CGSize avatarViewSize;

@property (weak, nonatomic, readwrite) UITapGestureRecognizer *tapGestureRecognizer;

- (void)jsq_handleTapGesture:(UITapGestureRecognizer *)tap;

- (void)jsq_updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant;

@end


@implementation JSQMessagesCollectionViewCell

#pragma mark - Class methods

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jsqMessagesCollectionViewCellActions = [NSMutableSet new];
    });
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (NSString *)mediaCellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@_JSQMedia", NSStringFromClass([self class])];
}

+ (void)registerMenuAction:(SEL)action
{
    [jsqMessagesCollectionViewCellActions addObject:NSStringFromSelector(action)];
}


#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    self.backgroundColor = [UIColor whiteColor];
    self.avatarViewSize = CGSizeZero;
    
    UIFont *topLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.cellTopLabel.textAlignment = NSTextAlignmentCenter;
    self.cellTopLabel.font = topLabelFont;
    self.cellTopLabel.textColor = [UIColor lightGrayColor];
    self.cellTopLabel.numberOfLines = 0;
    
    UIFont *messageBubbleTopLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
    self.messageBubbleTopLabel.font = messageBubbleTopLabelFont;
    self.messageBubbleTopLabel.textColor = [UIColor lightGrayColor];
    self.messageBubbleTopLabel.numberOfLines = 0;
    
    UIFont *bottomLabelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    self.cellBottomLabel.font = bottomLabelFont;
    self.cellBottomLabel.textColor = [UIColor lightGrayColor];
    self.cellBottomLabel.numberOfLines = 0;

    [self configureAccessoryButton];

    self.cellTopLabelHeightConstraint.constant = topLabelFont.pointSize;
    self.messageBubbleTopLabelHeightConstraint.constant = messageBubbleTopLabelFont.pointSize;
    self.cellBottomLabelHeightConstraint.constant = bottomLabelFont.pointSize;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jsq_handleTapGesture:)];
    [self addGestureRecognizer:tap];
    self.tapGestureRecognizer = tap;
}

- (void)configureAccessoryButton
{
    UIColor *tintColor = [UIColor lightGrayColor];
    UIImage *shareActionImage = [[UIImage jsq_shareActionImage] jsq_imageMaskedWithColor:tintColor];
    [self.accessoryButton setImage:shareActionImage forState:UIControlStateNormal];
}

- (void)dealloc
{
    _delegate = nil;

    _cellTopLabel = nil;
    _messageBubbleTopLabel = nil;
    _cellBottomLabel = nil;

    _textView = nil;
    _messageBubbleImageView = nil;
    _mediaView = nil;

    _avatarImageView = nil;

    [_tapGestureRecognizer removeTarget:nil action:NULL];
    _tapGestureRecognizer = nil;
}

#pragma mark - Collection view cell

- (void)prepareForReuse
{
    [super prepareForReuse];

    self.cellTopLabel.text = nil;
    self.messageBubbleTopLabel.text = nil;
    self.cellBottomLabel.text = nil;

    self.textView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.textView.text = nil;
    self.textView.attributedText = nil;

    self.avatarImageView.image = nil;
    self.avatarImageView.highlightedImage = nil;
    
    self.accessoryButton.hidden = YES;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    return layoutAttributes;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];

    JSQMessagesCollectionViewLayoutAttributes *customAttributes = (JSQMessagesCollectionViewLayoutAttributes *)layoutAttributes;

    if (self.textView.font != customAttributes.messageBubbleFont) {
        self.textView.font = customAttributes.messageBubbleFont;
    }

    if (!UIEdgeInsetsEqualToEdgeInsets(self.textView.textContainerInset, customAttributes.textViewTextContainerInsets)) {
        self.textView.textContainerInset = customAttributes.textViewTextContainerInsets;
    }

    self.textViewFrameInsets = customAttributes.textViewFrameInsets;

    [self jsq_updateConstraint:self.messageBubbleContainerWidthConstraint
                  withConstant:customAttributes.messageBubbleContainerViewWidth];

    [self jsq_updateConstraint:self.cellTopLabelHeightConstraint
                  withConstant:customAttributes.cellTopLabelHeight];

    [self jsq_updateConstraint:self.messageBubbleTopLabelHeightConstraint
                  withConstant:customAttributes.messageBubbleTopLabelHeight];

    [self jsq_updateConstraint:self.cellBottomLabelHeightConstraint
                  withConstant:customAttributes.cellBottomLabelHeight];

    if ([self isKindOfClass:[JSQMessagesCollectionViewCellIncoming class]]) {
        self.avatarViewSize = customAttributes.incomingAvatarViewSize;
    }
    else if ([self isKindOfClass:[JSQMessagesCollectionViewCellOutgoing class]]) {
        self.avatarViewSize = customAttributes.outgoingAvatarViewSize;
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.avatarImageView.highlighted = highlighted;
    self.messageBubbleImageView.highlighted = highlighted;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.avatarImageView.highlighted = selected;
    self.messageBubbleImageView.highlighted = selected;
}


#pragma mark - Menu actions

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([jsqMessagesCollectionViewCellActions containsObject:NSStringFromSelector(aSelector)]) {
        return YES;
    }

    return [super respondsToSelector:aSelector];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // do nothing
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // do nothing
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // do nothing
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // do nothing
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([jsqMessagesCollectionViewCellActions containsObject:NSStringFromSelector(anInvocation.selector)]) {
        __unsafe_unretained id sender;
        [anInvocation getArgument:&sender atIndex:0];
        [self.delegate messagesCollectionViewCell:self didPerformAction:anInvocation.selector withSender:sender];
    }
    else {
        [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([jsqMessagesCollectionViewCellActions containsObject:NSStringFromSelector(aSelector)]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }

    return [super methodSignatureForSelector:aSelector];
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];

    self.cellTopLabel.backgroundColor = backgroundColor;
    self.messageBubbleTopLabel.backgroundColor = backgroundColor;
    self.cellBottomLabel.backgroundColor = backgroundColor;

    self.messageBubbleImageView.backgroundColor = backgroundColor;
    self.avatarImageView.backgroundColor = backgroundColor;

    self.messageBubbleContainerView.backgroundColor = backgroundColor;
    self.avatarContainerView.backgroundColor = backgroundColor;
}

- (void)setAvatarViewSize:(CGSize)avatarViewSize
{
    if (CGSizeEqualToSize(avatarViewSize, self.avatarViewSize)) {
        return;
    }

    [self jsq_updateConstraint:self.avatarContainerViewWidthConstraint withConstant:avatarViewSize.width];
    [self jsq_updateConstraint:self.avatarContainerViewHeightConstraint withConstant:avatarViewSize.height];
}

- (void)setTextViewFrameInsets:(UIEdgeInsets)textViewFrameInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(textViewFrameInsets, self.textViewFrameInsets)) {
        return;
    }

    [self jsq_updateConstraint:self.textViewTopVerticalSpaceConstraint withConstant:textViewFrameInsets.top];
    [self jsq_updateConstraint:self.textViewBottomVerticalSpaceConstraint withConstant:textViewFrameInsets.bottom];
    [self jsq_updateConstraint:self.textViewAvatarHorizontalSpaceConstraint withConstant:textViewFrameInsets.right];
    [self jsq_updateConstraint:self.textViewMarginHorizontalSpaceConstraint withConstant:textViewFrameInsets.left];
}

- (void)setMediaView:(UIView *)mediaView
{
    [self.messageBubbleImageView removeFromSuperview];
    [self.textView removeFromSuperview];

    [mediaView setTranslatesAutoresizingMaskIntoConstraints:NO];
    mediaView.frame = self.messageBubbleContainerView.bounds;

    [self.messageBubbleContainerView addSubview:mediaView];
    [self.messageBubbleContainerView jsq_pinAllEdgesOfSubview:mediaView];
    _mediaView = mediaView;

    //  because of cell re-use (and caching media views, if using built-in library media item)
    //  we may have dequeued a cell with a media view and add this one on top
    //  thus, remove any additional subviews hidden behind the new media view
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.messageBubbleContainerView.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger index, BOOL *stop) {
            if (subview != _mediaView) {
                [subview removeFromSuperview];
            }
        }];
    });
}

#pragma mark - Getters

- (CGSize)avatarViewSize
{
    return CGSizeMake(self.avatarContainerViewWidthConstraint.constant,
                      self.avatarContainerViewHeightConstraint.constant);
}

- (UIEdgeInsets)textViewFrameInsets
{
    return UIEdgeInsetsMake(self.textViewTopVerticalSpaceConstraint.constant,
                            self.textViewMarginHorizontalSpaceConstraint.constant,
                            self.textViewBottomVerticalSpaceConstraint.constant,
                            self.textViewAvatarHorizontalSpaceConstraint.constant);
}

#pragma mark - Utilities

- (void)jsq_updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant
{
    if (constraint.constant == constant) {
        return;
    }

    constraint.constant = constant;
}

#pragma mark - Gesture recognizers

- (void)jsq_handleTapGesture:(UITapGestureRecognizer *)tap
{
    CGPoint touchPt = [tap locationInView:self];

    if (CGRectContainsPoint(self.avatarContainerView.frame, touchPt)) {
        [self.delegate messagesCollectionViewCellDidTapAvatar:self];
    }
    else if (CGRectContainsPoint(self.messageBubbleContainerView.frame, touchPt)) {
        [self.delegate messagesCollectionViewCellDidTapMessageBubble:self];
    }
    else {
        [self.delegate messagesCollectionViewCellDidTapCell:self atPosition:touchPt];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPt = [touch locationInView:self];

    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return CGRectContainsPoint(self.messageBubbleContainerView.frame, touchPt);
    }
    
    return NO;
}

- (IBAction)didTapAccessoryButton:(UIButton *)accessoryButton
{
    [self.delegate messagesCollectionViewCellDidTapAccessoryButton:self];
}

@end
