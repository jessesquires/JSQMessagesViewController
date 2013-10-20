//
//  JSMessagesViewController.m
//
//  Created by Jesse Squires on 2/12/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//
//  http://www.hexedbits.com
//
//
//  Largely based on work by Sam Soffes
//  https://github.com/soffes
//
//  SSMessagesViewController
//  https://github.com/soffes/ssmessagesviewcontroller
//
//
//  The MIT License
//  Copyright (c) 2013 Jesse Squires
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "JSMessagesViewController.h"
#import "NSString+JSMessagesView.h"
#import "UIView+AnimationOptionsForCurve.h"
#import "UIColor+JSMessagesView.h"
#import "JSDismissiveTextView.h"

#define INPUT_HEIGHT 40.0f

@interface JSMessagesViewController () <JSDismissiveTextViewDelegate>

- (void)setup;
@property BOOL isUserScrolling;

@end



@implementation JSMessagesViewController

#pragma mark - Initialization
- (void)setup
{
    if([self.view isKindOfClass:[UIScrollView class]]) {
        // fix for ipad modal form presentations
        ((UIScrollView *)self.view).scrollEnabled = NO;
    }
	
	self.preventScrollToBottomWhileUserScrolling = NO;
	self.isUserScrolling = NO;
    
    CGSize size = self.view.frame.size;
	
    CGRect tableFrame = CGRectMake(0.0f, 0.0f, size.width, size.height - INPUT_HEIGHT);
	self.tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	[self.view addSubview:self.tableView];
	
    [self setBackgroundColor:[UIColor messagesBackgroundColor]];
    
    CGRect inputFrame = CGRectMake(0.0f, size.height - INPUT_HEIGHT, size.width, INPUT_HEIGHT);
    self.inputToolBarView = [[JSMessageInputView alloc] initWithFrame:inputFrame delegate:self];
    
    // TODO: refactor
    self.inputToolBarView.textView.dismissivePanGestureRecognizer = self.tableView.panGestureRecognizer;
    self.inputToolBarView.textView.keyboardDelegate = self;
	
    UIButton *sendButton = [self sendButton];
    sendButton.enabled = NO;
    sendButton.frame = CGRectMake(self.inputToolBarView.frame.size.width - 65.0f, 8.0f, 59.0f, 26.0f);
    [sendButton addTarget:self
                   action:@selector(sendPressed:)
         forControlEvents:UIControlEventTouchUpInside];
    [self.inputToolBarView setSendButton:sendButton];
    [self.view addSubview:self.inputToolBarView];
}

- (UIButton *)sendButton
{
    return [UIButton defaultSendButton];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self scrollToBottomAnimated:NO];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillShowKeyboard:)
												 name:UIKeyboardWillShowNotification
                                               object:nil];
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleWillHideKeyboard:)
												 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.inputToolBarView resignFirstResponder];
    [self setEditing:NO animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"*** %@: didReceiveMemoryWarning ***", self.class);
}

- (void)dealloc
{
    self.delegate = nil;
    self.dataSource = nil;
    self.tableView = nil;
    self.inputToolBarView = nil;
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
    [self.delegate sendPressed:sender
                      withText:[self.inputToolBarView.textView.text trimWhitespace]];
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
    JSBubbleMessageStyle bubbleStyle = [self.delegate messageStyleForRowAtIndexPath:indexPath];
    JSAvatarStyle avatarStyle = JSAvatarStyleNone;
	if([self.delegate respondsToSelector:@selector(avatarStyle)])
		avatarStyle = [self.delegate avatarStyle];
    
    BOOL hasTimestamp = [self shouldHaveTimestampForRowAtIndexPath:indexPath];
    BOOL hasAvatar = [self shouldHaveAvatarForRowAtIndexPath:indexPath];
	
	BOOL hasSubtitle = NO;
	if([self.delegate respondsToSelector:@selector(hasSubtitleForRowAtIndexPath:)])
		hasSubtitle = [self.delegate hasSubtitleForRowAtIndexPath:indexPath];
    
    NSString *CellID = [NSString stringWithFormat:@"MessageCell_%d_%d_%d_%d", type, bubbleStyle, hasTimestamp, hasAvatar];
    JSBubbleMessageCell *cell = (JSBubbleMessageCell *)[tableView dequeueReusableCellWithIdentifier:CellID];
    
    if(!cell)
        cell = [[JSBubbleMessageCell alloc] initWithBubbleType:type
                                                   bubbleStyle:bubbleStyle
                                                   avatarStyle:(hasAvatar) ? avatarStyle : JSAvatarStyleNone
                                                  hasTimestamp:hasTimestamp
												   hasSubtitle:hasSubtitle
                                               reuseIdentifier:CellID];
    
    if(hasTimestamp)
        [cell setTimestamp:[self.dataSource timestampForRowAtIndexPath:indexPath]];
	
	if(hasSubtitle)
		[cell setSubtitle:[self.dataSource subtitleForRowAtIndexPath:indexPath]];
    
    if(hasAvatar) {
        switch (type) {
            case JSBubbleMessageTypeIncoming:
				if([self.dataSource respondsToSelector:@selector(avatarImageForIncomingMessageAtIndexPath:)]) {
					[cell setAvatarImage:[self.dataSource avatarImageForIncomingMessageAtIndexPath:indexPath]];
				}
				else if([self.dataSource respondsToSelector:@selector(avatarImageForIncomingMessage)]) {
					[cell setAvatarImage:[self.dataSource performSelector:@selector(avatarImageForIncomingMessage)]];
				}
				
                break;
                
            case JSBubbleMessageTypeOutgoing:
				if([self.dataSource respondsToSelector:@selector(avatarImageForOutgoingMessageAtIndexPath:)]) {
					[cell setAvatarImage:[self.dataSource avatarImageForOutgoingMessageAtIndexPath:indexPath]];
				}
				else if([self.dataSource respondsToSelector:@selector(avatarImageForOutgoingMessage)]) {
					[cell setAvatarImage:[self.dataSource performSelector:@selector(avatarImageForOutgoingMessage)]];
				}
				
                break;
        }
    }
    
    [cell setMessage:[self.dataSource textForRowAtIndexPath:indexPath]];
    [cell setBackgroundColor:tableView.backgroundColor];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	BOOL hasSubtitle = NO;
	if([self.delegate respondsToSelector:@selector(hasSubtitleForRowAtIndexPath:)]) {
		hasSubtitle = [self.delegate hasSubtitleForRowAtIndexPath:indexPath];
	}
	
    return [JSBubbleMessageCell neededHeightForText:[self.dataSource textForRowAtIndexPath:indexPath]
                                          timestamp:[self shouldHaveTimestampForRowAtIndexPath:indexPath]
										   subtitle:hasSubtitle
                                             avatar:[self shouldHaveAvatarForRowAtIndexPath:indexPath]];
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
	if(![self.delegate respondsToSelector:@selector(avatarPolicy)]) {
		return NO;
	}
	
    switch ([self.delegate avatarPolicy]) {
        case JSMessagesViewAvatarPolicyIncomingOnly:
            return [self.delegate messageTypeForRowAtIndexPath:indexPath] == JSBubbleMessageTypeIncoming;
			
		case JSMessagesViewAvatarPolicyOutgoingOnly:
			return [self.delegate messageTypeForRowAtIndexPath:indexPath] == JSBubbleMessageTypeOutgoing;
            
        case JSMessagesViewAvatarPolicyBoth:
            return YES;
            
        case JSMessagesViewAvatarPolicyNone:
        default:
            return NO;
    }
}

- (void)finishSend
{
    [self.inputToolBarView.textView setText:nil];
    [self textViewDidChange:self.inputToolBarView.textView];
	
	if([self.delegate respondsToSelector:@selector(messageDoneSending)]) {
		[self.delegate messageDoneSending];
	}
	else {
		[self.tableView reloadData];
		[self scrollToBottomAnimated:YES];
	}
}

- (void)setBackgroundColor:(UIColor *)color
{
    self.view.backgroundColor = color;
    self.tableView.backgroundColor = color;
    self.tableView.separatorColor = color;
}

- (void)scrollToBottomAnimated:(BOOL)animated
{
	if(self.isUserScrolling && self.preventScrollToBottomWhileUserScrolling) return;
	
    NSInteger rows = [self.tableView numberOfRowsInSection:0];
    
    if(rows > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:rows - 1 inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:animated];
    }
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath
			  atScrollPosition:(UITableViewScrollPosition)position
					  animated:(BOOL)animated{
	if(self.isUserScrolling && self.preventScrollToBottomWhileUserScrolling) return;
	
	[self.tableView scrollToRowAtIndexPath:indexPath
						  atScrollPosition:position
								  animated:animated];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	self.isUserScrolling = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	self.isUserScrolling = YES;
}

#pragma mark - Text view delegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [textView becomeFirstResponder];
	
    if(!self.previousTextViewContentHeight)
		self.previousTextViewContentHeight = textView.contentSize.height;
    
    [self scrollToBottomAnimated:YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [textView resignFirstResponder];
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat maxHeight = [JSMessageInputView maxHeight];
    CGFloat textViewContentHeight = textView.contentSize.height;
    BOOL isShrinking = textViewContentHeight < self.previousTextViewContentHeight;
    CGFloat changeInHeight = textViewContentHeight - self.previousTextViewContentHeight;
    
    if(!isShrinking && self.previousTextViewContentHeight == maxHeight) {
        changeInHeight = 0;
    }
    else {
        changeInHeight = MIN(changeInHeight, maxHeight - self.previousTextViewContentHeight);
    }
    
    if(changeInHeight != 0.0f) {
        if(!isShrinking)
            [self.inputToolBarView adjustTextViewHeightBy:changeInHeight];
        
        [UIView animateWithDuration:0.25f
                         animations:^{
                             UIEdgeInsets insets = UIEdgeInsetsMake(0.0f,
                                                                    0.0f,
                                                                    self.tableView.contentInset.bottom + changeInHeight,
                                                                    0.0f);
                             
                             self.tableView.contentInset = insets;
                             self.tableView.scrollIndicatorInsets = insets;
                             [self scrollToBottomAnimated:NO];
                             
                             CGRect inputViewFrame = self.inputToolBarView.frame;
                             self.inputToolBarView.frame = CGRectMake(0.0f,
                                                                      inputViewFrame.origin.y - changeInHeight,
                                                                      inputViewFrame.size.width,
                                                                      inputViewFrame.size.height + changeInHeight);
                         }
                         completion:^(BOOL finished) {
                             if(isShrinking)
                                 [self.inputToolBarView adjustTextViewHeightBy:changeInHeight];
                         }];
        
        self.previousTextViewContentHeight = MIN(textViewContentHeight, maxHeight);
    }
    
    self.inputToolBarView.sendButton.enabled = ([textView.text trimWhitespace].length > 0);
}

#pragma mark - Keyboard notifications
- (void)handleWillShowKeyboard:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}

- (void)handleWillHideKeyboard:(NSNotification *)notification
{
    [self keyboardWillShowHide:notification];
}

- (void)keyboardWillShowHide:(NSNotification *)notification
{
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:[UIView animationOptionsForCurve:curve]
                     animations:^{
                         CGFloat keyboardY = [self.view convertRect:keyboardRect fromView:nil].origin.y;
                         
                         CGRect inputViewFrame = self.inputToolBarView.frame;
                         CGFloat inputViewFrameY = keyboardY - inputViewFrame.size.height;
                         
                         // for ipad modal form presentations
                         CGFloat messageViewFrameBottom = self.view.frame.size.height - INPUT_HEIGHT;
                         if(inputViewFrameY > messageViewFrameBottom)
                             inputViewFrameY = messageViewFrameBottom;
						 
                         self.inputToolBarView.frame = CGRectMake(inputViewFrame.origin.x,
																  inputViewFrameY,
																  inputViewFrame.size.width,
																  inputViewFrame.size.height);
                         
                         UIEdgeInsets insets = UIEdgeInsetsMake(0.0f,
                                                                0.0f,
                                                                self.view.frame.size.height - self.inputToolBarView.frame.origin.y - INPUT_HEIGHT,
                                                                0.0f);
                         
                         self.tableView.contentInset = insets;
                         self.tableView.scrollIndicatorInsets = insets;
                     }
                     completion:^(BOOL finished) {
                     }];
}

#pragma mark - Dismissive text view delegate
- (void)keyboardDidScrollToPoint:(CGPoint)pt
{
    CGRect inputViewFrame = self.inputToolBarView.frame;
    CGPoint keyboardOrigin = [self.view convertPoint:pt fromView:nil];
    inputViewFrame.origin.y = keyboardOrigin.y - inputViewFrame.size.height;
    self.inputToolBarView.frame = inputViewFrame;
}

- (void)keyboardWillBeDismissed
{
    CGRect inputViewFrame = self.inputToolBarView.frame;
    inputViewFrame.origin.y = self.view.bounds.size.height - inputViewFrame.size.height;
    self.inputToolBarView.frame = inputViewFrame;
}

- (void)keyboardWillSnapBackToPoint:(CGPoint)pt
{
    CGRect inputViewFrame = self.inputToolBarView.frame;
    CGPoint keyboardOrigin = [self.view convertPoint:pt fromView:nil];
    inputViewFrame.origin.y = keyboardOrigin.y - inputViewFrame.size.height;
    self.inputToolBarView.frame = inputViewFrame;
}

@end