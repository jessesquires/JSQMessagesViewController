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

#import "JSQMessagesViewController.h"

#import "JSQMessagesKeyboardController.h"

#import "JSQMessageData.h"
#import "JSQMessage.h"

#import "JSQMessagesCollectionViewCellIncoming.h"
#import "JSQMessagesCollectionViewCellOutgoing.h"

#import "JSQMessagesTypingIndicatorFooterView.h"
#import "JSQMessagesLoadEarlierHeaderView.h"

#import "JSQMessagesToolbarContentView.h"
#import "JSQMessagesInputToolbar.h"
#import "JSQMessagesComposerTextView.h"

#import "JSQMessagesTimestampFormatter.h"

#import "NSString+JSQMessages.h"
#import "UIColor+JSQMessages.h"


static void * kJSQMessagesKeyValueObservingContext = &kJSQMessagesKeyValueObservingContext;



@interface JSQMessagesViewController () <JSQMessagesInputToolbarDelegate,
                                         JSQMessagesCollectionViewCellDelegate,
                                         JSQMessagesKeyboardControllerDelegate,
                                         UITextViewDelegate>

@property (weak, nonatomic) IBOutlet JSQMessagesCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet JSQMessagesInputToolbar *inputToolbar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottomLayoutGuide;

@property (strong, nonatomic) JSQMessagesKeyboardController *keyboardController;

@property (assign, nonatomic) CGFloat statusBarChangeInHeight;

- (void)jsq_configureMessagesViewController;

- (void)jsq_prepareForRotation;

- (void)jsq_finishSendingOrReceivingMessage;

- (JSQMessage *)jsq_currentlyComposedMessage;

- (void)jsq_updateKeyboardTriggerPoint;
- (void)jsq_setToolbarBottomLayoutGuideConstant:(CGFloat)constant;

- (void)jsq_handleInteractivePopGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;

- (BOOL)jsq_inputToolbarHasReachedMaximumHeight;
- (void)jsq_adjustInputToolbarForComposerTextViewContentSizeChange:(CGFloat)dy;
- (void)jsq_adjustInputToolbarHeightConstraintByDelta:(CGFloat)dy;
- (void)jsq_scrollComposerTextViewToBottomAnimated:(BOOL)animated;

- (void)jsq_updateCollectionViewInsets;
- (void)jsq_setCollectionViewInsetsTopValue:(CGFloat)top bottomValue:(CGFloat)bottom;

- (void)jsq_addObservers;
- (void)jsq_removeObservers;

- (void)jsq_registerForNotifications:(BOOL)registerForNotifications;

- (void)jsq_addActionToInteractivePopGestureRecognizer:(BOOL)addAction;

@end



@implementation JSQMessagesViewController

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesViewController class])
                          bundle:[NSBundle mainBundle]];
}

+ (instancetype)messagesViewController
{
    return [[[self class] alloc] initWithNibName:NSStringFromClass([JSQMessagesViewController class])
                                          bundle:[NSBundle mainBundle]];
}

#pragma mark - Initialization

- (void)jsq_configureMessagesViewController
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.toolbarHeightContraint.constant = kJSQMessagesInputToolbarHeightDefault;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.inputToolbar.delegate = self;
    self.inputToolbar.contentView.textView.placeHolder = NSLocalizedString(@"New Message", @"Placeholder text for the message input text view");
    self.inputToolbar.contentView.textView.delegate = self;
    
    self.sender = @"JSQDefaultSender";
    
    self.automaticallyScrollsToMostRecentMessage = YES;
    
    self.outgoingCellIdentifier = [JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier];
    self.incomingCellIdentifier = [JSQMessagesCollectionViewCellIncoming cellReuseIdentifier];
    
    self.typingIndicatorColor = [UIColor jsq_messageBubbleLightGrayColor];
    self.showTypingIndicator = NO;
    
    self.showLoadEarlierMessagesHeader = NO;
    
    [self jsq_updateCollectionViewInsets];
    
    self.keyboardController = [[JSQMessagesKeyboardController alloc] initWithTextView:self.inputToolbar.contentView.textView
                                                                          contextView:self.view
                                                                 panGestureRecognizer:self.collectionView.panGestureRecognizer
                                                                             delegate:self];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([JSQMessagesViewController class])
                                      owner:self
                                    options:nil];
    }
    return self;
}

- (void)dealloc
{
    [self jsq_registerForNotifications:NO];
    [self jsq_removeObservers];
    
    _collectionView.dataSource = nil;
    _collectionView.delegate = nil;
    _collectionView = nil;
    _inputToolbar = nil;
    
    _toolbarHeightContraint = nil;
    _toolbarBottomLayoutGuide = nil;
    
    _sender = nil;
    _outgoingCellIdentifier = nil;
    _incomingCellIdentifier = nil;
    
    [_keyboardController endListeningForKeyboard];
    _keyboardController = nil;
}

#pragma mark - Setters

- (void)setShowTypingIndicator:(BOOL)showTypingIndicator
{
    if (_showTypingIndicator == showTypingIndicator) {
        return;
    }
    
    _showTypingIndicator = showTypingIndicator;
    
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self scrollToBottomAnimated:YES];
}

- (void)setShowLoadEarlierMessagesHeader:(BOOL)showLoadEarlierMessagesHeader
{
    if (_showLoadEarlierMessagesHeader == showLoadEarlierMessagesHeader) {
        return;
    }
    
    _showLoadEarlierMessagesHeader = showLoadEarlierMessagesHeader;
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self jsq_configureMessagesViewController];
    [self jsq_registerForNotifications:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    [self.collectionView.collectionViewLayout invalidateLayout];
    
    if (self.automaticallyScrollsToMostRecentMessage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self scrollToBottomAnimated:NO];
            [self.collectionView.collectionViewLayout invalidateLayout];
        });
    }
    
    [self jsq_updateKeyboardTriggerPoint];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self jsq_addObservers];
    [self jsq_addActionToInteractivePopGestureRecognizer:YES];
    [self.keyboardController beginListeningForKeyboard];
    
    self.collectionView.collectionViewLayout.springinessEnabled = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self jsq_removeObservers];
    [self jsq_addActionToInteractivePopGestureRecognizer:NO];
    [self.keyboardController endListeningForKeyboard];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"MEMORY WARNING: %s", __PRETTY_FUNCTION__);
}

#pragma mark - View rotation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self jsq_prepareForRotation];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self jsq_prepareForRotation];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self jsq_prepareForRotation];
    
    // TODO: deal with keyboard on rotation
}

- (void)jsq_prepareForRotation
{
    // TODO: deal with keyboard on rotation
    
    [self.inputToolbar.contentView.textView resignFirstResponder];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

#pragma mark - Messages view controller

- (void)didPressSendButton:(UIButton *)sender withMessage:(JSQMessage *)message { }

- (void)didPressAccessoryButton:(UIButton *)sender { }

- (void)finishSendingMessage
{
    UITextView *textView = self.inputToolbar.contentView.textView;
    textView.text = nil;
    
    [self.inputToolbar toggleSendButtonEnabled];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:textView];
    
    [self jsq_finishSendingOrReceivingMessage];
}

- (void)finishReceivingMessage
{
    [self jsq_finishSendingOrReceivingMessage];
}

- (void)jsq_finishSendingOrReceivingMessage
{
    self.showTypingIndicator = NO;
    
    [self.collectionView reloadData];
    
    if (self.automaticallyScrollsToMostRecentMessage) {
        [self scrollToBottomAnimated:YES];
    }
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    if ([self.collectionView numberOfSections] == 0) {
        return;
    }
    
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    
    if (items > 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:items - 1 inSection:0]
                                    atScrollPosition:UICollectionViewScrollPositionTop
                                            animated:animated];
    }
}

#pragma mark - JSQMessages collection view data source

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView sender:(NSString *)sender bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView sender:(NSString *)sender avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView sender:(NSString *)sender attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView sender:(NSString *)sender attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView sender:(NSString *)sender attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<JSQMessageData> messageData = [collectionView.dataSource collectionView:collectionView messageDataForItemAtIndexPath:indexPath];
    NSAssert(messageData, @"ERROR: messageData must not be nil: %s", __PRETTY_FUNCTION__);
    
    NSString *messageSender = [messageData sender];
    NSAssert(messageSender, @"ERROR: messageData sender must not be nil: %s", __PRETTY_FUNCTION__);
    
    BOOL isOutgoingMessage = [messageSender isEqualToString:self.sender];
    
    NSString *cellIdentifier = isOutgoingMessage ? self.outgoingCellIdentifier : self.incomingCellIdentifier;
    JSQMessagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    NSString *messageText = [messageData text];
    NSAssert(messageText, @"ERROR: messageData text must not be nil: %s", __PRETTY_FUNCTION__);
    
    cell.textView.text = messageText;
    
    cell.messageBubbleImageView = [collectionView.dataSource collectionView:collectionView
                                                                     sender:messageSender bubbleImageViewForItemAtIndexPath:indexPath];
    
    cell.avatarImageView = [collectionView.dataSource collectionView:collectionView
                                                              sender:messageSender avatarImageViewForItemAtIndexPath:indexPath];
    
    cell.cellTopLabel.attributedText = [collectionView.dataSource collectionView:collectionView
                                                                          sender:messageSender attributedTextForCellTopLabelAtIndexPath:indexPath];
    
    cell.messageBubbleTopLabel.attributedText = [collectionView.dataSource collectionView:collectionView
                                                                                   sender:messageSender attributedTextForMessageBubbleTopLabelAtIndexPath:indexPath];
    
    cell.cellBottomLabel.attributedText = [collectionView.dataSource collectionView:collectionView
                                                                             sender:messageSender attributedTextForCellBottomLabelAtIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    CGFloat bubbleTopLabelInset = collectionView.collectionViewLayout.messageBubbleTopLabelLeftRightInset;
    
    if (isOutgoingMessage) {
        cell.messageBubbleTopLabel.textInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, bubbleTopLabelInset);
    }
    else {
        cell.textView.textColor = [UIColor blackColor];
        cell.messageBubbleTopLabel.textInsets = UIEdgeInsetsMake(0.0f, bubbleTopLabelInset, 0.0f, 0.0f);
    }
    
    cell.textView.dataDetectorTypes = UIDataDetectorTypeAll;
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(JSQMessagesCollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if (self.showTypingIndicator && [kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [collectionView dequeueTypingIndicatorFooterViewIncoming:YES
                                                     withIndicatorColor:[self.typingIndicatorColor jsq_colorByDarkeningColorWithValue:0.3f]
                                                            bubbleColor:self.typingIndicatorColor
                                                           forIndexPath:indexPath];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [collectionView dequeueLoadEarlierMessagesViewHeaderForIndexPath:indexPath];
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (!self.showTypingIndicator) {
        return CGSizeZero;
    }
    
    return CGSizeMake([collectionViewLayout itemWidth], kJSQMessagesTypingIndicatorFooterViewHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (!self.showLoadEarlierMessagesHeader) {
        return CGSizeZero;
    }
    
    return CGSizeMake([collectionViewLayout itemWidth], kJSQMessagesLoadEarlierHeaderViewHeight);
}

#pragma mark - Collection view delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(JSQMessagesCollectionView *)collectionView
                  layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize bubbleSize = [collectionViewLayout messageBubbleSizeForItemAtIndexPath:indexPath];
    
    CGFloat cellHeight = bubbleSize.height;
    cellHeight += [self collectionView:collectionView layout:collectionViewLayout heightForCellTopLabelAtIndexPath:indexPath];
    cellHeight += [self collectionView:collectionView layout:collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:indexPath];
    cellHeight += [self collectionView:collectionView layout:collectionViewLayout heightForCellBottomLabelAtIndexPath:indexPath];
    
    return CGSizeMake(collectionViewLayout.itemWidth, cellHeight);
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
 didTapAvatarImageView:(UIImageView *)avatarImageView
           atIndexPath:(NSIndexPath *)indexPath { }

#pragma mark - Messages collection view cell delegate

- (void)messagesCollectionViewCellDidTapAvatar:(JSQMessagesCollectionViewCell *)cell
{
    [self.collectionView.delegate collectionView:self.collectionView
                           didTapAvatarImageView:cell.avatarImageView
                                     atIndexPath:[self.collectionView indexPathForCell:cell]];
}

#pragma mark - Input toolbar delegate

- (void)messagesInputToolbar:(JSQMessagesInputToolbar *)toolbar didPressLeftBarButton:(UIButton *)sender
{
    if (toolbar.sendButtonOnRight) {
        [self didPressAccessoryButton:sender];
    }
    else {
        [self didPressSendButton:sender withMessage:[self jsq_currentlyComposedMessage]];
    }
}

- (void)messagesInputToolbar:(JSQMessagesInputToolbar *)toolbar didPressRightBarButton:(UIButton *)sender
{
    if (toolbar.sendButtonOnRight) {
        [self didPressSendButton:sender withMessage:[self jsq_currentlyComposedMessage]];
    }
    else {
        [self didPressAccessoryButton:sender];
    }
}

- (JSQMessage *)jsq_currentlyComposedMessage
{
    //  add a space to accept any auto-correct suggestions
    NSString *text = self.inputToolbar.contentView.textView.text;
    self.inputToolbar.contentView.textView.text = [text stringByAppendingString:@" "];
    
    return [JSQMessage messageWithText:[self.inputToolbar.contentView.textView.text jsq_stringByTrimingWhitespace]
                                sender:self.sender];
}

#pragma mark - Text view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
    
    if (self.automaticallyScrollsToMostRecentMessage) {
        [self scrollToBottomAnimated:YES];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self.inputToolbar toggleSendButtonEnabled];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

#pragma mark - Notifications

- (void)jsq_handleDidChangeStatusBarFrameNotification:(NSNotification *)notification
{
    CGRect previousStatusBarFrame = [[[notification userInfo] objectForKey:UIApplicationStatusBarFrameUserInfoKey] CGRectValue];
    CGRect currentStatusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    CGFloat statusBarHeightDelta = CGRectGetHeight(currentStatusBarFrame) - CGRectGetHeight(previousStatusBarFrame);
    self.statusBarChangeInHeight = MAX(statusBarHeightDelta, 0.0f);
    
    if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        self.statusBarChangeInHeight = 0.0f;
    }
}

#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kJSQMessagesKeyValueObservingContext) {
        
        if (object == self.inputToolbar.contentView.textView
            && [keyPath isEqualToString:NSStringFromSelector(@selector(contentSize))]) {
            
            CGSize oldContentSize = [[change objectForKey:NSKeyValueChangeOldKey] CGSizeValue];
            CGSize newContentSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
            
            CGFloat dy = newContentSize.height - oldContentSize.height;
        
            [self jsq_adjustInputToolbarForComposerTextViewContentSizeChange:dy];
            [self jsq_updateCollectionViewInsets];
            if (self.automaticallyScrollsToMostRecentMessage) {
                [self scrollToBottomAnimated:NO];
            }
        }
    }
}

#pragma mark - Keyboard controller delegate

- (void)keyboardDidChangeFrame:(CGRect)keyboardFrame
{
    CGRect keyboardFrameConverted = [self.view convertRect:keyboardFrame fromView:nil];
    
    CGFloat heightFromBottom = CGRectGetHeight(self.collectionView.frame) - CGRectGetMinY(keyboardFrameConverted);
    
    heightFromBottom = MAX(0.0f, heightFromBottom + self.statusBarChangeInHeight);
    
    [self jsq_setToolbarBottomLayoutGuideConstant:heightFromBottom];
}

- (void)jsq_setToolbarBottomLayoutGuideConstant:(CGFloat)constant
{
    self.toolbarBottomLayoutGuide.constant = constant;
    [self.view setNeedsUpdateConstraints];
    [self.view layoutIfNeeded];
    
    [self jsq_updateCollectionViewInsets];
}

- (void)jsq_updateKeyboardTriggerPoint
{
    self.keyboardController.keyboardTriggerPoint = CGPointMake(0.0f, CGRectGetHeight(self.inputToolbar.bounds));
}

#pragma mark - Gesture recognizers

- (void)jsq_handleInteractivePopGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self.keyboardController endListeningForKeyboard];
            [self.inputToolbar.contentView.textView resignFirstResponder];
            [UIView animateWithDuration:0.0
                             animations:^{
                                 [self jsq_setToolbarBottomLayoutGuideConstant:0.0f];
                             }];
        }
            break;
        case UIGestureRecognizerStateChanged:
            //  TODO: handle this animation better
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
            [self.keyboardController beginListeningForKeyboard];
            break;
        default:
            break;
    }
}

#pragma mark - Input toolbar utilities

- (BOOL)jsq_inputToolbarHasReachedMaximumHeight
{
    return (CGRectGetMinY(self.inputToolbar.frame) == self.topLayoutGuide.length);
}

- (void)jsq_adjustInputToolbarForComposerTextViewContentSizeChange:(CGFloat)dy
{
    BOOL contentSizeIsIncreasing = (dy > 0);
    
    if ([self jsq_inputToolbarHasReachedMaximumHeight]) {
        BOOL contentOffsetIsPositive = (self.inputToolbar.contentView.textView.contentOffset.y > 0);
        
        if (contentSizeIsIncreasing || contentOffsetIsPositive) {
            [self jsq_scrollComposerTextViewToBottomAnimated:YES];
            return;
        }
    }
    
    CGFloat toolbarOriginY = CGRectGetMinY(self.inputToolbar.frame);
    CGFloat newToolbarOriginY = toolbarOriginY - dy;
    
    //  attempted to increase origin.Y above topLayoutGuide
    if (newToolbarOriginY <= self.topLayoutGuide.length) {
        dy = toolbarOriginY - self.topLayoutGuide.length;
        [self jsq_scrollComposerTextViewToBottomAnimated:YES];
    }
    
    [self jsq_adjustInputToolbarHeightConstraintByDelta:dy];
    
    [self jsq_updateKeyboardTriggerPoint];
    
    if (dy < 0) {
        [self jsq_scrollComposerTextViewToBottomAnimated:NO];
    }
}

- (void)jsq_adjustInputToolbarHeightConstraintByDelta:(CGFloat)dy
{
    self.toolbarHeightContraint.constant += dy;
    
    if (self.toolbarHeightContraint.constant < kJSQMessagesInputToolbarHeightDefault) {
        self.toolbarHeightContraint.constant = kJSQMessagesInputToolbarHeightDefault;
    }
    
    [self.view setNeedsUpdateConstraints];
    [self.view layoutIfNeeded];
}

- (void)jsq_scrollComposerTextViewToBottomAnimated:(BOOL)animated
{
    UITextView *textView = self.inputToolbar.contentView.textView;
    CGPoint contentOffsetToShowLastLine = CGPointMake(0.0f, textView.contentSize.height - CGRectGetHeight(textView.bounds));
    
    if (!animated) {
        textView.contentOffset = contentOffsetToShowLastLine;
        return;
    }
    
    [UIView animateWithDuration:0.01
                          delay:0.01
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         textView.contentOffset = contentOffsetToShowLastLine;
                     }
                     completion:nil];
}

#pragma mark - Collection view utilities

- (void)jsq_updateCollectionViewInsets
{
    [self jsq_setCollectionViewInsetsTopValue:self.topLayoutGuide.length
                                  bottomValue:CGRectGetHeight(self.collectionView.frame) - CGRectGetMinY(self.inputToolbar.frame)];
}

- (void)jsq_setCollectionViewInsetsTopValue:(CGFloat)top bottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = UIEdgeInsetsMake(top, 0.0f, bottom, 0.0f);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}

#pragma mark - Utilities

- (void)jsq_addObservers
{
    [self jsq_removeObservers];
    
    [self.inputToolbar.contentView.textView addObserver:self
                                             forKeyPath:NSStringFromSelector(@selector(contentSize))
                                                options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                                                context:kJSQMessagesKeyValueObservingContext];
}

- (void)jsq_removeObservers
{
    @try {
        [self.inputToolbar.contentView.textView removeObserver:self
                                                    forKeyPath:NSStringFromSelector(@selector(contentSize))
                                                       context:kJSQMessagesKeyValueObservingContext];
    }
    @catch (NSException * __unused exception) { }
}

- (void)jsq_registerForNotifications:(BOOL)registerForNotifications
{
    if (registerForNotifications) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(jsq_handleDidChangeStatusBarFrameNotification:)
                                                     name:UIApplicationDidChangeStatusBarFrameNotification
                                                   object:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIApplicationDidChangeStatusBarFrameNotification
                                                      object:nil];
    }
}

- (void)jsq_addActionToInteractivePopGestureRecognizer:(BOOL)addAction
{
    if (self.navigationController.interactivePopGestureRecognizer) {
        [self.navigationController.interactivePopGestureRecognizer removeTarget:nil
                                                                         action:@selector(jsq_handleInteractivePopGestureRecognizer:)];
        
        if (addAction) {
            [self.navigationController.interactivePopGestureRecognizer addTarget:self
                                                                          action:@selector(jsq_handleInteractivePopGestureRecognizer:)];
        }
    }
}

@end
