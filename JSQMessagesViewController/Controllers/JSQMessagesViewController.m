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

#import "JSQMessagesViewController.h"

#import "JSQMessagesCollectionViewFlowLayoutInvalidationContext.h"

#import "JSQMessageData.h"
#import "JSQMessageBubbleImageDataSource.h"
#import "JSQMessageAvatarImageDataSource.h"

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
#import "UIDevice+JSQMessages.h"
#import "NSBundle+JSQMessages.h"


static void * kJSQMessagesKeyValueObservingContext = &kJSQMessagesKeyValueObservingContext;



@interface JSQMessagesViewController () <JSQMessagesInputToolbarDelegate,
                                         JSQMessagesKeyboardControllerDelegate,
                                         UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet JSQMessagesCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet JSQMessagesInputToolbar *inputToolbar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottomLayoutGuide;

@property (weak, nonatomic) UIView *snapshotView;

@property (assign, nonatomic) BOOL jsq_isObserving;

@property (strong, nonatomic) NSIndexPath *selectedIndexPathForMenu;

@property (weak, nonatomic) UIGestureRecognizer *currentInteractivePopGestureRecognizer;

@property (assign, nonatomic) BOOL textViewWasFirstResponderDuringInteractivePop;

@end



@implementation JSQMessagesViewController

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesViewController class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesViewController class]]];
}

+ (instancetype)messagesViewController
{
    return [[[self class] alloc] initWithNibName:NSStringFromClass([JSQMessagesViewController class])
                                          bundle:[NSBundle bundleForClass:[JSQMessagesViewController class]]];
}

#pragma mark - Initialization

- (void)jsq_configureMessagesViewController
{
    self.view.backgroundColor = [UIColor whiteColor];

    self.jsq_isObserving = NO;

    self.toolbarHeightConstraint.constant = self.inputToolbar.preferredDefaultHeight;

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    self.inputToolbar.delegate = self;
    self.inputToolbar.contentView.textView.placeHolder = [NSBundle jsq_localizedStringForKey:@"new_message"];
    self.inputToolbar.contentView.textView.delegate = self;

    self.outgoingCellIdentifier = [JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier];
    self.outgoingMediaCellIdentifier = [JSQMessagesCollectionViewCellOutgoing mediaCellReuseIdentifier];

    self.incomingCellIdentifier = [JSQMessagesCollectionViewCellIncoming cellReuseIdentifier];
    self.incomingMediaCellIdentifier = [JSQMessagesCollectionViewCellIncoming mediaCellReuseIdentifier];

    // NOTE: let this behavior be opt-in for now
    // [JSQMessagesCollectionViewCell registerMenuAction:@selector(delete:)];

    self.showTypingIndicator = NO;

    self.showLoadEarlierMessagesHeader = NO;

    self.topContentAdditionalInset = 0.0f;

    [self jsq_updateCollectionViewInsets];

    // Don't set keyboardController if client creates custom content view via -loadToolbarContentView
    if (self.inputToolbar.contentView.textView != nil) {
        self.keyboardController = [[JSQMessagesKeyboardController alloc] initWithTextView:self.inputToolbar.contentView.textView
                                                                              contextView:self.view
                                                                     panGestureRecognizer:self.collectionView.panGestureRecognizer
                                                                                 delegate:self];
    }

    _isLastCellVisible = false;
}

- (void)dealloc
{
    [self jsq_registerForNotifications:NO];
    [self jsq_removeObservers];

    _collectionView.dataSource = nil;
    _collectionView.delegate = nil;

    _inputToolbar.contentView.textView.delegate = nil;
    _inputToolbar.delegate = nil;

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
    [self.collectionView.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)setShowLoadEarlierMessagesHeader:(BOOL)showLoadEarlierMessagesHeader
{
    if (_showLoadEarlierMessagesHeader == showLoadEarlierMessagesHeader) {
        return;
    }

    _showLoadEarlierMessagesHeader = showLoadEarlierMessagesHeader;
    [self.collectionView.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}

- (void)setTopContentAdditionalInset:(CGFloat)topContentAdditionalInset
{
    _topContentAdditionalInset = topContentAdditionalInset;
    [self jsq_updateCollectionViewInsets];
}

- (void)setIsLastCellVisible {
    NSInteger finalRow = MAX(0, [self.collectionView numberOfItemsInSection:0] - 1);

    if ([[self.collectionView indexPathsForVisibleItems] count] == 0) {
        _isLastCellVisible = finalRow == 0;
        return;
    }

    // Calculate the CGRect for the last item in the view
    NSIndexPath *finalRowIndexPath = [NSIndexPath indexPathForRow:finalRow inSection:0];
    UICollectionViewLayoutAttributes *theAttributes = [self.collectionView layoutAttributesForItemAtIndexPath:finalRowIndexPath];
    CGRect cellRect = [self.collectionView convertRect:theAttributes.frame toView:self.collectionView.superview];

    // Calculate the CGRect for the visible part of the screen for drawing items
    CGRect visibleRect = CGRectMake(_collectionView.bounds.origin.x,
            self.collectionView.bounds.origin.y,
            self.collectionView.bounds.size.width,
            self.collectionView.bounds.size.height - self.collectionView.contentInset.bottom);
    visibleRect = [self.collectionView convertRect:visibleRect toView:self.collectionView.superview];

    // Finally check if the @cellRect is contained within the @visibleRect
    _isLastCellVisible = CGRectContainsRect(visibleRect, cellRect);
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[[self class] nib] instantiateWithOwner:self options:nil];

    [self jsq_configureMessagesViewController];
    [self jsq_registerForNotifications:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSParameterAssert(self.senderId != nil);
    NSParameterAssert(self.senderDisplayName != nil);

    [super viewWillAppear:animated];
    [self.view layoutIfNeeded];
    [self.collectionView.collectionViewLayout invalidateLayout];

    if ([self shouldScrollOnStartup]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self scrollToBottomAnimated:NO];
            [self.collectionView.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
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

    if ([UIDevice jsq_isCurrentDeviceBeforeiOS8]) {
        [self.snapshotView removeFromSuperview];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.collectionView.collectionViewLayout.springinessEnabled = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self jsq_addActionToInteractivePopGestureRecognizer:NO];
    [self jsq_removeObservers];
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

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskAll;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.collectionView.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    if (self.showTypingIndicator) {
        self.showTypingIndicator = NO;
        self.showTypingIndicator = YES;
        [self.collectionView reloadData];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self jsq_resetLayoutAndCaches];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self jsq_resetLayoutAndCaches];
}

- (void)jsq_resetLayoutAndCaches
{
    JSQMessagesCollectionViewFlowLayoutInvalidationContext *context = [JSQMessagesCollectionViewFlowLayoutInvalidationContext context];
    context.invalidateFlowLayoutMessagesCache = YES;
    [self.collectionView.collectionViewLayout invalidateLayoutWithContext:context];
}

#pragma mark - Messages view controller

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
    NSAssert(NO, @"Error! required method not implemented in subclass. Need to implement %s", __PRETTY_FUNCTION__);
}

- (void)didPressAccessoryButton:(UIButton *)sender
{
    NSAssert(NO, @"Error! required method not implemented in subclass. Need to implement %s", __PRETTY_FUNCTION__);
}

- (void)finishSendingMessage
{
    [self finishSendingMessageAnimated:YES];
}

- (void)finishSendingMessageAnimated:(BOOL)animated {

    UITextView *textView = self.inputToolbar.contentView.textView;
    textView.text = nil;
    [textView.undoManager removeAllActions];

    [self.inputToolbar toggleSendButtonEnabled];

    [[NSNotificationCenter defaultCenter] postNotificationName:UITextViewTextDidChangeNotification object:textView];

    [self.collectionView.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
    [self.collectionView reloadData];

    if ([self shouldScroll]) {
        [self scrollToBottomAnimated:animated];
    }
}

- (void)finishReceivingMessage
{
    [self finishReceivingMessageAnimated:YES];
}

- (void)finishReceivingMessageAnimated:(BOOL)animated {

    self.showTypingIndicator = NO;

    [self.collectionView.collectionViewLayout invalidateLayoutWithContext:[JSQMessagesCollectionViewFlowLayoutInvalidationContext context]];
    [self.collectionView reloadData];

    if ([self shouldScroll] && ![self jsq_isMenuVisible]) {
        [self scrollToBottomAnimated:animated];
    }
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
    if ([self.collectionView numberOfSections] == 0) {
        return;
    }

    NSInteger items = [self.collectionView numberOfItemsInSection:0];

    if (items == 0) {
        return;
    }

    CGFloat collectionViewContentHeight = [self.collectionView.collectionViewLayout collectionViewContentSize].height;
    BOOL isContentTooSmall = (collectionViewContentHeight < CGRectGetHeight(self.collectionView.bounds));

    _isLastCellVisible = true;

    if (isContentTooSmall) {
        //  workaround for the first few messages not scrolling
        //  when the collection view content size is too small, `scrollToItemAtIndexPath:` doesn't work properly
        //  this seems to be a UIKit bug, see #256 on GitHub
        [self.collectionView scrollRectToVisible:CGRectMake(0.0, collectionViewContentHeight - 1.0f, 1.0f, 1.0f)
                                        animated:animated];
        return;
    }

    //  workaround for really long messages not scrolling
    //  if last message is too long, use scroll position bottom for better appearance, else use top
    //  possibly a UIKit bug, see #480 on GitHub
    NSInteger finalRow = MAX(0, [self.collectionView numberOfItemsInSection:0] - 1);
    NSIndexPath *finalIndexPath = [NSIndexPath indexPathForItem:finalRow inSection:0];
    CGSize finalCellSize = [self.collectionView.collectionViewLayout sizeForItemAtIndexPath:finalIndexPath];

    CGFloat maxHeightForVisibleMessage = CGRectGetHeight(self.collectionView.bounds) - self.collectionView.contentInset.top - CGRectGetHeight(self.inputToolbar.bounds);

    UICollectionViewScrollPosition scrollPosition = (finalCellSize.height > maxHeightForVisibleMessage) ? UICollectionViewScrollPositionBottom : UICollectionViewScrollPositionTop;

    [self.collectionView scrollToItemAtIndexPath:finalIndexPath
                                atScrollPosition:scrollPosition
                                        animated:animated];
}

- (BOOL)isOutgoingMessage:(id<JSQMessageData>)messageItem
{
    NSString *messageSenderId = [messageItem senderId];
    NSParameterAssert(messageSenderId != nil);
    
    return [messageSenderId isEqualToString:self.senderId];
}

#pragma mark - JSQMessages collection view data source

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
}

- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(NO, @"ERROR: required method not implemented: %s", __PRETTY_FUNCTION__);
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
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
    id<JSQMessageData> messageItem = [collectionView.dataSource collectionView:collectionView messageDataForItemAtIndexPath:indexPath];
    NSParameterAssert(messageItem != nil);
    
    BOOL isOutgoingMessage = [self isOutgoingMessage:messageItem];
    BOOL isMediaMessage = [messageItem isMediaMessage];

    NSString *cellIdentifier = nil;
    if (isMediaMessage) {
        cellIdentifier = isOutgoingMessage ? self.outgoingMediaCellIdentifier : self.incomingMediaCellIdentifier;
    }
    else {
        cellIdentifier = isOutgoingMessage ? self.outgoingCellIdentifier : self.incomingCellIdentifier;
    }

    JSQMessagesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = collectionView;

    if (!isMediaMessage) {
        cell.textView.text = [messageItem text];

        if ([UIDevice jsq_isCurrentDeviceBeforeiOS8]) {
            //  workaround for iOS 7 textView data detectors bug
            cell.textView.text = nil;
            cell.textView.attributedText = [[NSAttributedString alloc] initWithString:[messageItem text]
                                                                           attributes:@{ NSFontAttributeName : collectionView.collectionViewLayout.messageBubbleFont }];
        }

        NSParameterAssert(cell.textView.text != nil);

        id<JSQMessageBubbleImageDataSource> bubbleImageDataSource = [collectionView.dataSource collectionView:collectionView messageBubbleImageDataForItemAtIndexPath:indexPath];
        cell.messageBubbleImageView.image = [bubbleImageDataSource messageBubbleImage];
        cell.messageBubbleImageView.highlightedImage = [bubbleImageDataSource messageBubbleHighlightedImage];
    }
    else {
        id<JSQMessageMediaData> messageMedia = [messageItem media];
        cell.mediaView = [messageMedia mediaView] ?: [messageMedia mediaPlaceholderView];
        NSParameterAssert(cell.mediaView != nil);
    }

    BOOL needsAvatar = YES;
    if (isOutgoingMessage && CGSizeEqualToSize(collectionView.collectionViewLayout.outgoingAvatarViewSize, CGSizeZero)) {
        needsAvatar = NO;
    }
    else if (!isOutgoingMessage && CGSizeEqualToSize(collectionView.collectionViewLayout.incomingAvatarViewSize, CGSizeZero)) {
        needsAvatar = NO;
    }

    id<JSQMessageAvatarImageDataSource> avatarImageDataSource = nil;
    if (needsAvatar) {
        avatarImageDataSource = [collectionView.dataSource collectionView:collectionView avatarImageDataForItemAtIndexPath:indexPath];
        if (avatarImageDataSource != nil) {

            UIImage *avatarImage = [avatarImageDataSource avatarImage];
            if (avatarImage == nil) {
                cell.avatarImageView.image = [avatarImageDataSource avatarPlaceholderImage];
                cell.avatarImageView.highlightedImage = nil;
            }
            else {
                cell.avatarImageView.image = avatarImage;
                cell.avatarImageView.highlightedImage = [avatarImageDataSource avatarHighlightedImage];
            }
        }
    }

    cell.cellTopLabel.attributedText = [collectionView.dataSource collectionView:collectionView attributedTextForCellTopLabelAtIndexPath:indexPath];
    cell.messageBubbleTopLabel.attributedText = [collectionView.dataSource collectionView:collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:indexPath];
    cell.cellBottomLabel.attributedText = [collectionView.dataSource collectionView:collectionView attributedTextForCellBottomLabelAtIndexPath:indexPath];

    CGFloat bubbleTopLabelInset = (avatarImageDataSource != nil) ? 60.0f : 15.0f;

    if (isOutgoingMessage) {
        cell.messageBubbleTopLabel.textInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, bubbleTopLabelInset);
    }
    else {
        cell.messageBubbleTopLabel.textInsets = UIEdgeInsetsMake(0.0f, bubbleTopLabelInset, 0.0f, 0.0f);
    }

    cell.textView.dataDetectorTypes = UIDataDetectorTypeAll;

    cell.backgroundColor = [UIColor clearColor];
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    cell.layer.shouldRasterize = YES;

    return cell;
}

- (UICollectionReusableView *)collectionView:(JSQMessagesCollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if (self.showTypingIndicator && [kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [collectionView dequeueTypingIndicatorFooterViewForIndexPath:indexPath];
    }
    else if (self.showLoadEarlierMessagesHeader && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
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

- (BOOL)collectionView:(JSQMessagesCollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //  disable menu for media messages
    id<JSQMessageData> messageItem = [collectionView.dataSource collectionView:collectionView messageDataForItemAtIndexPath:indexPath];
    if ([messageItem isMediaMessage]) {
        return NO;
    }

    self.selectedIndexPathForMenu = indexPath;

    //  textviews are selectable to allow data detectors
    //  however, this allows the 'copy, define, select' UIMenuController to show
    //  which conflicts with the collection view's UIMenuController
    //  temporarily disable 'selectable' to prevent this issue
    JSQMessagesCollectionViewCell *selectedCell = (JSQMessagesCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    selectedCell.textView.selectable = NO;

    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(copy:) || action == @selector(delete:)) {
        return YES;
    }

    return NO;
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    if (action == @selector(copy:)) {
        id<JSQMessageData> messageData = [collectionView.dataSource collectionView:collectionView messageDataForItemAtIndexPath:indexPath];
        [[UIPasteboard generalPasteboard] setString:[messageData text]];
    }
    else if (action == @selector(delete:)) {
        [collectionView.dataSource collectionView:collectionView didDeleteMessageAtIndexPath:indexPath];

        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
        [collectionView.collectionViewLayout invalidateLayout];
    }
}

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(JSQMessagesCollectionView *)collectionView
                  layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionViewLayout sizeForItemAtIndexPath:indexPath];
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

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath { }

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
 didTapCellAtIndexPath:(NSIndexPath *)indexPath
         touchLocation:(CGPoint)touchLocation { }

#pragma mark - Input toolbar delegate

- (void)messagesInputToolbar:(JSQMessagesInputToolbar *)toolbar didPressLeftBarButton:(UIButton *)sender
{
    if (toolbar.sendButtonOnRight) {
        [self didPressAccessoryButton:sender];
    }
    else {
        [self didPressSendButton:sender
                 withMessageText:[self jsq_currentlyComposedMessageText]
                        senderId:self.senderId
               senderDisplayName:self.senderDisplayName
                            date:[NSDate date]];
    }
}

- (void)messagesInputToolbar:(JSQMessagesInputToolbar *)toolbar didPressRightBarButton:(UIButton *)sender
{
    if (toolbar.sendButtonOnRight) {
        [self didPressSendButton:sender
                 withMessageText:[self jsq_currentlyComposedMessageText]
                        senderId:self.senderId
               senderDisplayName:self.senderDisplayName
                            date:[NSDate date]];
    }
    else {
        [self didPressAccessoryButton:sender];
    }
}

- (NSString *)jsq_currentlyComposedMessageText
{
    //  auto-accept any auto-correct suggestions
    [self.inputToolbar.contentView.textView.inputDelegate selectionWillChange:self.inputToolbar.contentView.textView];
    [self.inputToolbar.contentView.textView.inputDelegate selectionDidChange:self.inputToolbar.contentView.textView];

    return [self.inputToolbar.contentView.textView.text jsq_stringByTrimingWhitespace];
}

#pragma mark - Text view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView != self.inputToolbar.contentView.textView) {
        return;
    }

    [textView becomeFirstResponder];

    if ([self shouldScroll]) {
        [self scrollToBottomAnimated:YES];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView != self.inputToolbar.contentView.textView) {
        return;
    }

    [self.inputToolbar toggleSendButtonEnabled];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView != self.inputToolbar.contentView.textView) {
        return;
    }

    [textView resignFirstResponder];
}

#pragma mark - Notifications

- (void)jsq_handleDidChangeStatusBarFrameNotification:(NSNotification *)notification
{
    if (self.keyboardController.keyboardIsVisible) {
        [self jsq_setToolbarBottomLayoutGuideConstant:CGRectGetHeight(self.keyboardController.currentKeyboardFrame)];
    }
}

- (void)jsq_didReceiveMenuWillShowNotification:(NSNotification *)notification
{
    if (!self.selectedIndexPathForMenu) {
        return;
    }

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIMenuControllerWillShowMenuNotification
                                                  object:nil];

    UIMenuController *menu = [notification object];
    [menu setMenuVisible:NO animated:NO];

    JSQMessagesCollectionViewCell *selectedCell = (JSQMessagesCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPathForMenu];
    CGRect selectedCellMessageBubbleFrame = [selectedCell convertRect:selectedCell.messageBubbleContainerView.frame toView:self.view];

    [menu setTargetRect:selectedCellMessageBubbleFrame inView:self.view];
    [menu setMenuVisible:YES animated:YES];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(jsq_didReceiveMenuWillShowNotification:)
                                                 name:UIMenuControllerWillShowMenuNotification
                                               object:nil];
}

- (void)jsq_didReceiveMenuWillHideNotification:(NSNotification *)notification
{
    if (!self.selectedIndexPathForMenu) {
        return;
    }

    //  per comment above in 'shouldShowMenuForItemAtIndexPath:'
    //  re-enable 'selectable', thus re-enabling data detectors if present
    JSQMessagesCollectionViewCell *selectedCell = (JSQMessagesCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.selectedIndexPathForMenu];
    selectedCell.textView.selectable = YES;
    self.selectedIndexPathForMenu = nil;
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
            if ([self shouldScroll]) {
                [self scrollToBottomAnimated:NO];
            }
        }
    }
}

#pragma mark - Keyboard controller delegate

- (void)keyboardController:(JSQMessagesKeyboardController *)keyboardController keyboardDidChangeFrame:(CGRect)keyboardFrame
{
    if (![self.inputToolbar.contentView.textView isFirstResponder] && self.toolbarBottomLayoutGuide.constant == 0.0f) {
        return;
    }

    CGFloat heightFromBottom = CGRectGetMaxY(self.collectionView.frame) - CGRectGetMinY(keyboardFrame);

    heightFromBottom = MAX(0.0f, heightFromBottom);

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
            if ([UIDevice jsq_isCurrentDeviceBeforeiOS8]) {
                [self.snapshotView removeFromSuperview];
            }

            self.textViewWasFirstResponderDuringInteractivePop = [self.inputToolbar.contentView.textView isFirstResponder];

            [self.keyboardController endListeningForKeyboard];

            if ([UIDevice jsq_isCurrentDeviceBeforeiOS8]) {
                [self.inputToolbar.contentView.textView resignFirstResponder];
                [UIView animateWithDuration:0.0
                                 animations:^{
                                     [self jsq_setToolbarBottomLayoutGuideConstant:0.0f];
                                 }];

                UIView *snapshot = [self.view snapshotViewAfterScreenUpdates:YES];
                [self.view addSubview:snapshot];
                self.snapshotView = snapshot;
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
            [self.keyboardController beginListeningForKeyboard];
            if (self.textViewWasFirstResponderDuringInteractivePop) {
                [self.inputToolbar.contentView.textView becomeFirstResponder];
            }

            if ([UIDevice jsq_isCurrentDeviceBeforeiOS8]) {
                [self.snapshotView removeFromSuperview];
            }
            break;
        default:
            break;
    }
}

#pragma mark - Input toolbar utilities

- (BOOL)jsq_inputToolbarHasReachedMaximumHeight
{
    return CGRectGetMinY(self.inputToolbar.frame) == (self.topLayoutGuide.length + self.topContentAdditionalInset);
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
    if (newToolbarOriginY <= self.topLayoutGuide.length + self.topContentAdditionalInset) {
        dy = toolbarOriginY - (self.topLayoutGuide.length + self.topContentAdditionalInset);
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
    CGFloat proposedHeight = self.toolbarHeightConstraint.constant + dy;

    CGFloat finalHeight = MAX(proposedHeight, self.inputToolbar.preferredDefaultHeight);

    if (self.inputToolbar.maximumHeight != NSNotFound) {
        finalHeight = MIN(finalHeight, self.inputToolbar.maximumHeight);
    }

    if (self.toolbarHeightConstraint.constant != finalHeight) {
        self.toolbarHeightConstraint.constant = finalHeight;
        [self.view setNeedsUpdateConstraints];
        [self.view layoutIfNeeded];
    }
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
    [self jsq_setCollectionViewInsetsTopValue:self.topLayoutGuide.length + self.topContentAdditionalInset
                                  bottomValue:CGRectGetMaxY(self.collectionView.frame) - CGRectGetMinY(self.inputToolbar.frame)];
}

- (void)jsq_setCollectionViewInsetsTopValue:(CGFloat)top bottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = UIEdgeInsetsMake(top, 0.0f, bottom, 0.0f);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}

- (BOOL)jsq_isMenuVisible
{
    //  check if cell copy menu is showing
    //  it is only our menu if `selectedIndexPathForMenu` is not `nil`
    return self.selectedIndexPathForMenu != nil && [[UIMenuController sharedMenuController] isMenuVisible];
}

#pragma mark - Utilities

/**
 * Determines whether we should scroll to the end or not.
 *
 * Returns true as default.
 */
- (BOOL)shouldScroll {
    if (_scrollingDelegate == nil) {
        return true;
    }

    NSUInteger finalRow = MAX(0, [self.collectionView numberOfItemsInSection:0] - 1);
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:finalRow inSection:0];
    return [_scrollingDelegate shouldScrollToNewlyReceivedMessageAtIndexPath:indexPath];
}

- (BOOL)shouldScrollOnStartup {
    if (_scrollingDelegate == nil) {
        return true;
    }

    return [_scrollingDelegate shouldScrollToLastMessageAtStartup];
}

- (void)jsq_addObservers
{
    if (self.jsq_isObserving) {
        return;
    }

    [self.inputToolbar.contentView.textView addObserver:self
                                             forKeyPath:NSStringFromSelector(@selector(contentSize))
                                                options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                                                context:kJSQMessagesKeyValueObservingContext];

    self.jsq_isObserving = YES;
}

- (void)jsq_removeObservers
{
    if (!_jsq_isObserving) {
        return;
    }

    @try {
        [_inputToolbar.contentView.textView removeObserver:self
                                                forKeyPath:NSStringFromSelector(@selector(contentSize))
                                                   context:kJSQMessagesKeyValueObservingContext];
    }
    @catch (NSException * __unused exception) { }

    _jsq_isObserving = NO;
}

- (void)jsq_registerForNotifications:(BOOL)registerForNotifications
{
    if (registerForNotifications) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(jsq_handleDidChangeStatusBarFrameNotification:)
                                                     name:UIApplicationDidChangeStatusBarFrameNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(jsq_didReceiveMenuWillShowNotification:)
                                                     name:UIMenuControllerWillShowMenuNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(jsq_didReceiveMenuWillHideNotification:)
                                                     name:UIMenuControllerWillHideMenuNotification
                                                   object:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIApplicationDidChangeStatusBarFrameNotification
                                                      object:nil];

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIMenuControllerWillShowMenuNotification
                                                      object:nil];

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIMenuControllerWillHideMenuNotification
                                                      object:nil];
    }
}

- (void)jsq_addActionToInteractivePopGestureRecognizer:(BOOL)addAction
{
    if (self.currentInteractivePopGestureRecognizer != nil) {
        [self.currentInteractivePopGestureRecognizer removeTarget:nil
                                                           action:@selector(jsq_handleInteractivePopGestureRecognizer:)];
        self.currentInteractivePopGestureRecognizer = nil;
    }

    if (addAction) {
        [self.navigationController.interactivePopGestureRecognizer addTarget:self
                                                                      action:@selector(jsq_handleInteractivePopGestureRecognizer:)];
        self.currentInteractivePopGestureRecognizer = self.navigationController.interactivePopGestureRecognizer;
    }
}

#pragma mark - UIScrollView delegate methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self setIsLastCellVisible];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self setIsLastCellVisible];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate)
        [self setIsLastCellVisible];
}

@end
