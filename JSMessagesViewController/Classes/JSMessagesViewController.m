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
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "JSMessagesViewController.h"
#import "JSMessageTextView.h"
#import "NSString+JSMessagesView.h"

@interface JSMessagesViewController () <JSDismissiveTextViewDelegate>

@property (assign, nonatomic) CGFloat previousTextViewContentHeight;
@property (assign, nonatomic) BOOL isUserScrolling;

- (void)setup;

- (void)sendPressed:(UIButton *)sender;

- (BOOL)shouldHaveTimestampForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)shouldHaveAvatarForRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)shouldHaveSubtitleForRowAtIndexPath:(NSIndexPath *)indexPath;

- (BOOL)shouldAllowScroll;

- (void)layoutAndAnimateMessageInputTextView:(UITextView *)textView;
- (void)setTableViewInsetsWithBottomValue:(CGFloat)bottom;
- (UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom;

- (void)handleWillShowKeyboardNotification:(NSNotification *)notification;
- (void)handleWillHideKeyboardNotification:(NSNotification *)notification;
- (void)keyboardWillShowHide:(NSNotification *)notification;

- (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve;

@end



@implementation JSMessagesViewController

#pragma mark - Initialization

- (void)setup
{
    if([self.view isKindOfClass:[UIScrollView class]]) {
        // FIXME: hack-ish fix for ipad modal form presentations
        ((UIScrollView *)self.view).scrollEnabled = NO;
    }
    
	_isUserScrolling = NO;
    
    CGSize size = self.view.frame.size;
    
    JSMessageInputViewStyle inputViewStyle = [self.delegate inputViewStyle];
    CGFloat inputViewHeight = (inputViewStyle == JSMessageInputViewStyleFlat) ? 45.0f : 40.0f;
    
    CGRect tableFrame = CGRectMake(0.0f, 0.0f, size.width, size.height - inputViewHeight);
	UITableView *tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
	tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	tableView.dataSource = self;
	tableView.delegate = self;
	[self.view addSubview:tableView];
	_tableView = tableView;
    
    [self setBackgroundColor:[UIColor js_backgroundColorClassic]];
    
    CGRect inputFrame = CGRectMake(0.0f,
                                   size.height - inputViewHeight,
                                   size.width,
                                   inputViewHeight);
    
    JSMessageInputView *inputView = [[JSMessageInputView alloc] initWithFrame:inputFrame
                                                                        style:inputViewStyle
                                                                     delegate:self
                                                         panGestureRecognizer:_tableView.panGestureRecognizer];
    
    if([self.delegate respondsToSelector:@selector(sendButtonForInputView)]) {
        UIButton *sendButton = [self.delegate sendButtonForInputView];
        [inputView setSendButton:sendButton];
    }
    
    inputView.sendButton.enabled = NO;
    [inputView.sendButton addTarget:self
                             action:@selector(sendPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:inputView];
    _messageInputView = inputView;
    
    [_messageInputView.textView addObserver:self
                                 forKeyPath:@"contentSize"
                                    options:NSKeyValueObservingOptionNew
                                    context:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    [[JSBubbleView appearance] setFont:[UIFont systemFontOfSize:16.0f]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self scrollToBottomAnimated:NO];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillShowKeyboardNotification:)
												 name:UIKeyboardWillShowNotification
                                               object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillHideKeyboardNotification:)
												 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self scrollToBottomAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.messageInputView resignFirstResponder];
    [self setEditing:NO animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"*** %@: didReceiveMemoryWarning ***", [self class]);
}

- (void)dealloc
{
    [_messageInputView.textView removeObserver:self forKeyPath:@"contentSize"];
    _delegate = nil;
    _dataSource = nil;
    _tableView = nil;
    _messageInputView = nil;
}

#pragma mark - View rotation

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.tableView reloadData];
    [self.tableView setNeedsLayout];
}

#pragma mark - Actions

- (void)sendPressed:(UIButton *)sender
{
    [self.delegate didSendText:[self.messageInputView.textView.text js_stringByTrimingWhitespace]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JSBubbleMessageType type = [self.delegate messageTypeForRowAtIndexPath:indexPath];
    
    UIImageView *bubbleImageView = [self.delegate bubbleImageViewWithType:type
                                                        forRowAtIndexPath:indexPath];
    
    BOOL hasTimestamp = [self shouldHaveTimestampForRowAtIndexPath:indexPath];
    BOOL hasAvatar = [self shouldHaveAvatarForRowAtIndexPath:indexPath];
	BOOL hasSubtitle = [self shouldHaveSubtitleForRowAtIndexPath:indexPath];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"MessageCell_%d_%d_%d_%d", (int)type, hasTimestamp, hasAvatar, hasSubtitle];
    JSBubbleMessageCell *cell = (JSBubbleMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(!cell) {
        cell = [[JSBubbleMessageCell alloc] initWithBubbleType:type
                                               bubbleImageView:bubbleImageView
                                                  hasTimestamp:hasTimestamp
                                                     hasAvatar:hasAvatar
                                                   hasSubtitle:hasSubtitle
                                               reuseIdentifier:CellIdentifier];
    }
    
    if(hasTimestamp) {
        [cell setTimestamp:[self.dataSource timestampForRowAtIndexPath:indexPath]];
    }
	
    if(hasAvatar) {
        [cell setAvatarImageView:[self.dataSource avatarImageViewForRowAtIndexPath:indexPath]];
    }
    
	if(hasSubtitle) {
		[cell setSubtitle:[self.dataSource subtitleForRowAtIndexPath:indexPath]];
    }
    
    [cell setMessage:[self.dataSource textForRowAtIndexPath:indexPath]];
    [cell setBackgroundColor:tableView.backgroundColor];
    
	#if TARGET_IPHONE_SIMULATOR
        cell.bubbleView.textView.dataDetectorTypes = UIDataDetectorTypeNone;
	#else
		cell.bubbleView.textView.dataDetectorTypes = UIDataDetectorTypeAll;
	#endif
	
    if([self.delegate respondsToSelector:@selector(configureCell:atIndexPath:)]) {
        [self.delegate configureCell:cell atIndexPath:indexPath];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [self.dataSource textForRowAtIndexPath:indexPath];
    
    BOOL hasTimestamp = [self shouldHaveTimestampForRowAtIndexPath:indexPath];
    BOOL hasAvatar = [self shouldHaveAvatarForRowAtIndexPath:indexPath];
	BOOL hasSubtitle = [self shouldHaveSubtitleForRowAtIndexPath:indexPath];
    
    return [JSBubbleMessageCell neededHeightForBubbleMessageCellWithText:text
                                                               timestamp:hasTimestamp
                                                                  avatar:hasAvatar
                                                                subtitle:hasSubtitle];
}

#pragma mark - Messages view controller

- (BOOL)shouldHaveTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([self.delegate timestampPolicy]) {
        case JSMessagesViewTimestampPolicyAll:
            return YES;
            
        case JSMessagesViewTimestampPolicyAlternating:
            return indexPath.row % 2 == 0;
            
        case JSMessagesViewTimestampPolicyEveryThree:
            return indexPath.row % 3 == 0;
            
        case JSMessagesViewTimestampPolicyEveryFive:
            return indexPath.row % 5 == 0;
            
        case JSMessagesViewTimestampPolicyCustom:
            if([self.delegate respondsToSelector:@selector(hasTimestampForRowAtIndexPath:)])
                return [self.delegate hasTimestampForRowAtIndexPath:indexPath];
            
        default:
            return NO;
    }
}

- (BOOL)shouldHaveAvatarForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch ([self.delegate avatarPolicy]) {
        case JSMessagesViewAvatarPolicyAll:
            return YES;
            
        case JSMessagesViewAvatarPolicyIncomingOnly:
            return [self.delegate messageTypeForRowAtIndexPath:indexPath] == JSBubbleMessageTypeIncoming;
			
		case JSMessagesViewAvatarPolicyOutgoingOnly:
			return [self.delegate messageTypeForRowAtIndexPath:indexPath] == JSBubbleMessageTypeOutgoing;
            
        case JSMessagesViewAvatarPolicyNone:
        default:
            return NO;
    }
}

- (BOOL)shouldHaveSubtitleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([self.delegate subtitlePolicy]) {
        case JSMessagesViewSubtitlePolicyAll:
            return YES;
        
        case JSMessagesViewSubtitlePolicyIncomingOnly:
            return [self.delegate messageTypeForRowAtIndexPath:indexPath] == JSBubbleMessageTypeIncoming;
            
        case JSMessagesViewSubtitlePolicyOutgoingOnly:
            return [self.delegate messageTypeForRowAtIndexPath:indexPath] == JSBubbleMessageTypeOutgoing;
            
        case JSMessagesViewSubtitlePolicyNone:
        default:
            return NO;
    }
}

- (void)finishSend
{
    [self.messageInputView.textView setText:nil];
    [self textViewDidChange:self.messageInputView.textView];
    [self.tableView reloadData];
}

- (void)setBackgroundColor:(UIColor *)color
{
    self.view.backgroundColor = color;
    _tableView.backgroundColor = color;
    _tableView.separatorColor = color;
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
	if(![self shouldAllowScroll])
        return;
	
    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    
    if(rows > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:animated];
    }
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath
			  atScrollPosition:(UITableViewScrollPosition)position
					  animated:(BOOL)animated
{
	if(![self shouldAllowScroll])
        return;
	
	[self.tableView scrollToRowAtIndexPath:indexPath
						  atScrollPosition:position
								  animated:animated];
}

- (BOOL)shouldAllowScroll
{
    if(self.isUserScrolling) {
        if([self.delegate respondsToSelector:@selector(shouldPreventScrollToBottomWhileUserScrolling)]
           && [self.delegate shouldPreventScrollToBottomWhileUserScrolling]) {
            return NO;
        }
    }
    
    return YES;
}

#pragma mark - Scroll view delegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
	self.isUserScrolling = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.isUserScrolling = NO;
}

#pragma mark - Text view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
	
    if(!self.previousTextViewContentHeight)
		self.previousTextViewContentHeight = textView.contentSize.height;
    
    [self scrollToBottomAnimated:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.messageInputView.sendButton.enabled = ([[textView.text js_stringByTrimingWhitespace] length] > 0);
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

#pragma mark - Layout message input view

- (void)layoutAndAnimateMessageInputTextView:(UITextView *)textView
{
    CGFloat maxHeight = [JSMessageInputView maxHeight];
    
    BOOL isShrinking = textView.contentSize.height < self.previousTextViewContentHeight;
    CGFloat changeInHeight = textView.contentSize.height - self.previousTextViewContentHeight;
    
    if(!isShrinking && (self.previousTextViewContentHeight == maxHeight || textView.text.length == 0)) {
        changeInHeight = 0;
    }
    else {
        changeInHeight = MIN(changeInHeight, maxHeight - self.previousTextViewContentHeight);
    }
    
    if(changeInHeight != 0.0f) {
        [UIView animateWithDuration:0.25f
                         animations:^{
                             [self setTableViewInsetsWithBottomValue:self.tableView.contentInset.bottom + changeInHeight];
                             
                             [self scrollToBottomAnimated:NO];
                             
                             if(isShrinking) {
                                 // if shrinking the view, animate text view frame BEFORE input view frame
                                 [self.messageInputView adjustTextViewHeightBy:changeInHeight];
                             }
                             
                             CGRect inputViewFrame = self.messageInputView.frame;
                             self.messageInputView.frame = CGRectMake(0.0f,
                                                                      inputViewFrame.origin.y - changeInHeight,
                                                                      inputViewFrame.size.width,
                                                                      inputViewFrame.size.height + changeInHeight);
                             
                             if(!isShrinking) {
                                 // growing the view, animate the text view frame AFTER input view frame
                                 [self.messageInputView adjustTextViewHeightBy:changeInHeight];
                             }
                         }
                         completion:^(BOOL finished) {
                         }];
        
        self.previousTextViewContentHeight = MIN(textView.contentSize.height, maxHeight);
    }
    
    // Once we reached the max height, we have to consider the bottom offset for the text view.
    // To make visible the last line, again we have to set the content offset.
    if (self.previousTextViewContentHeight == maxHeight) {
        double delayInSeconds = 0.01;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime,
                       dispatch_get_main_queue(),
                       ^(void) {
                           CGPoint bottomOffset = CGPointMake(0.0f, textView.contentSize.height - textView.bounds.size.height);
                           [textView setContentOffset:bottomOffset animated:YES];
                       });
    }
}

- (void)setTableViewInsetsWithBottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = [self tableViewInsetsWithBottomValue:bottom];
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
}

- (UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    
    if ([self respondsToSelector:@selector(topLayoutGuide)]) {
        insets.top = self.topLayoutGuide.length;
    }
    
    insets.bottom = bottom;
    
    return insets;
}

#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (object == self.messageInputView.textView && [keyPath isEqualToString:@"contentSize"]) {
        [self layoutAndAnimateMessageInputTextView:object];
    }
}

#pragma mark - Keyboard notifications

- (void)handleWillShowKeyboardNotification:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}

- (void)handleWillHideKeyboardNotification:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}

- (void)keyboardWillShowHide:(NSNotification *)notification
{
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:[self animationOptionsForCurve:curve]
                     animations:^{
                         CGFloat keyboardY = [self.view convertRect:keyboardRect fromView:nil].origin.y;
                         
                         CGRect inputViewFrame = self.messageInputView.frame;
                         CGFloat inputViewFrameY = keyboardY - inputViewFrame.size.height;
                         
                         // for ipad modal form presentations
                         CGFloat messageViewFrameBottom = self.view.frame.size.height - inputViewFrame.size.height;
                         if(inputViewFrameY > messageViewFrameBottom)
                             inputViewFrameY = messageViewFrameBottom;
						 
                         self.messageInputView.frame = CGRectMake(inputViewFrame.origin.x,
																  inputViewFrameY,
																  inputViewFrame.size.width,
																  inputViewFrame.size.height);

                         [self setTableViewInsetsWithBottomValue:self.view.frame.size.height
                                                                - self.messageInputView.frame.origin.y
                                                                - inputViewFrame.size.height];
                     }
                     completion:nil];
}

#pragma mark - Dismissive text view delegate

- (void)keyboardDidScrollToPoint:(CGPoint)point
{
    CGRect inputViewFrame = self.messageInputView.frame;
    CGPoint keyboardOrigin = [self.view convertPoint:point fromView:nil];
    inputViewFrame.origin.y = keyboardOrigin.y - inputViewFrame.size.height;
    self.messageInputView.frame = inputViewFrame;
}

- (void)keyboardWillBeDismissed
{
    CGRect inputViewFrame = self.messageInputView.frame;
    inputViewFrame.origin.y = self.view.bounds.size.height - inputViewFrame.size.height;
    self.messageInputView.frame = inputViewFrame;
}

- (void)keyboardWillSnapBackToPoint:(CGPoint)point
{
    if(!self.tabBarController.tabBar.hidden){
        return;
    }
	
    CGRect inputViewFrame = self.messageInputView.frame;
    CGPoint keyboardOrigin = [self.view convertPoint:point fromView:nil];
    inputViewFrame.origin.y = keyboardOrigin.y - inputViewFrame.size.height;
    self.messageInputView.frame = inputViewFrame;
}

#pragma mark - Utilities

- (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve
{
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
            
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
            
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
            
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
            
        default:
            return kNilOptions;
    }
}

@end
