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

#import <DAKeyboardControl/DAKeyboardControl.h>


static void * kJSQKeyValueObservingContext = &kJSQKeyValueObservingContext;


@interface JSQMessagesViewController ()

@property (weak, nonatomic) IBOutlet JSQMessagesCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet JSQMessagesInputToolbar *inputToolbar;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarHeightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottomLayoutGuide;

- (void)jsq_prepareForRotation;

- (void)jsq_updateKeyboardTriggerOffset;
- (BOOL)jsq_inputToolbarHasReachedMaximumHeight;
- (void)jsq_adjustInputToolbarForComposerTextViewContentSizeChange:(CGFloat)dy;
- (void)jsq_adjustInputToolbarHeightConstraintByDelta:(CGFloat)dy;
- (void)jsq_scrollComposerTextViewToBottomAnimated:(BOOL)animated;

- (void)jsq_updateCollectionViewInsets;
- (void)jsq_setCollectionViewInsetsWithBottomValue:(CGFloat)bottom;

@end



@implementation JSQMessagesViewController

#pragma mark - Class methods

+ (UIStoryboard *)messagesStoryboard
{
    return [UIStoryboard storyboardWithName:NSStringFromClass([JSQMessagesViewController class])
                                     bundle:[NSBundle mainBundle]];
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.toolbarHeightContraint.constant = kJSQMessagesInputToolbarHeightDefault;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    
    self.inputToolbar.contentView.textView.placeHolder = @"New Message";
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self jsq_updateCollectionViewInsets];
    [[JSQMessagesCollectionViewCell appearance] setFont:[UIFont systemFontOfSize:15.0f]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self jsq_updateKeyboardTriggerOffset];
    
    __weak JSQMessagesViewController *weakSelf = self;
    __weak UIView *weakView = self.view;
    __weak JSQMessagesInputToolbar *weakInputToolbar = self.inputToolbar;
    __weak NSLayoutConstraint *weakToolbarBottomLayoutGuide = self.toolbarBottomLayoutGuide;
    
    [self.view addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView) {
        CGRect newToolbarFrame = weakInputToolbar.frame;
        newToolbarFrame.origin.y = CGRectGetMinY(keyboardFrameInView) - CGRectGetHeight(newToolbarFrame);
        weakInputToolbar.frame = newToolbarFrame;
        
        CGFloat heightFromBottom = CGRectGetHeight(weakView.frame) - CGRectGetMinY(keyboardFrameInView);
        weakToolbarBottomLayoutGuide.constant = heightFromBottom;
        [weakSelf.view setNeedsUpdateConstraints];
        
        [weakSelf jsq_updateCollectionViewInsets];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.inputToolbar.contentView.textView addObserver:self
                                             forKeyPath:NSStringFromSelector(@selector(contentSize))
                                                options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                                                context:kJSQKeyValueObservingContext];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view removeKeyboardControl];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    @try {
        [self.inputToolbar.contentView.textView removeObserver:self
                                                    forKeyPath:NSStringFromSelector(@selector(contentSize))
                                                       context:kJSQKeyValueObservingContext];
    }
    @catch (NSException *exception) {
        NSLog(@"%s EXCEPTION CAUGHT : %@, %@", __PRETTY_FUNCTION__, exception, [exception userInfo]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

- (void)jsq_prepareForRotation
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.inputToolbar.contentView.textView setNeedsDisplay];
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesCollectionViewCellOutgoing *cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:[JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier]
                                                                                             forIndexPath:indexPath];
    
    JSQMessagesCollectionViewCellIncoming *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:[JSQMessagesCollectionViewCellIncoming cellReuseIdentifier]
                                                                                             forIndexPath:indexPath];
    
    cell1.cellTopLabel.text = @"time";
    cell1.messageBubbleTopLabel.text = @"sender";
    cell1.textView.text = @"some sample text";
    cell1.cellBottomLabel.text = @"sent";
    
    cell1.textView.textColor = [UIColor whiteColor];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView1.backgroundColor = [UIColor whiteColor];
    
    imgView1.image = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo-avatar-jobs"]
                                                      diameter:kJSQMessagesCollectionViewCellAvatarSizeDefault];
    cell1.avatarImageView = imgView1;
    cell1.messageBubbleImageView = [JSQMessagesBubbleImageFactory outgoingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleBlueColor]];
    
    
    
    cell2.cellTopLabel.text = @"time";
    cell2.messageBubbleTopLabel.text = @"recipient";
    cell2.textView.text = @"other text here";
//    cell2.textView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    cell2.cellBottomLabel.text = @"recieved";
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView2.backgroundColor = [UIColor whiteColor];
    imgView2.image = [JSQMessagesAvatarFactory avatarWithUserInitials:@"JSQ"
                                                      backgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]
                                                            textColor:[UIColor colorWithWhite:0.60f alpha:1.0f]
                                                                 font:[UIFont systemFontOfSize:14.0f]
                                                             diameter:kJSQMessagesCollectionViewCellAvatarSizeDefault];
    cell2.avatarImageView = imgView2;
    cell2.messageBubbleImageView = [JSQMessagesBubbleImageFactory incomingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleGreenColor]];
    
    
    return (indexPath.row % 2 == 0) ? cell2 : cell1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    return nil; // TODO:
}

#pragma mark - Collection view delegate

// TODO:

#pragma mark - Collection view delegate flow layout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO:
    JSQMessagesCollectionViewFlowLayout *layout = (JSQMessagesCollectionViewFlowLayout *)collectionViewLayout;
    CGFloat width = collectionView.frame.size.width - layout.sectionInset.left - layout.sectionInset.right;
    
//    CGRect stringRect = [txt boundingRectWithSize:CGSizeMake(maxWidth, maxHeight)
//                                          options:NSStringDrawingUsesLineFragmentOrigin
//                                       attributes:@{ NSFontAttributeName : [[JSBubbleView appearance] font] }
//                                          context:[[NSStringDrawingContext alloc] init]];
    
    
    return CGSizeMake(width, 200.0f);
}

#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kJSQKeyValueObservingContext) {
        
        if (object == self.inputToolbar.contentView.textView
            && [keyPath isEqualToString:NSStringFromSelector(@selector(contentSize))]) {
            
            CGSize oldContentSize = [[change objectForKey:NSKeyValueChangeOldKey] CGSizeValue];
            CGSize newContentSize = [[change objectForKey:NSKeyValueChangeNewKey] CGSizeValue];
            
            CGFloat dy = newContentSize.height - oldContentSize.height;
        
            [self jsq_adjustInputToolbarForComposerTextViewContentSizeChange:dy];
        }
    }
}

#pragma mark - Composer text view utilities

- (void)jsq_updateKeyboardTriggerOffset
{
    self.view.keyboardTriggerOffset = CGRectGetHeight(self.inputToolbar.bounds);
}

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
    
    [self jsq_updateKeyboardTriggerOffset];
    
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
    [self jsq_setCollectionViewInsetsWithBottomValue:CGRectGetHeight(self.collectionView.frame) - CGRectGetMinY(self.inputToolbar.frame)];
}

- (void)jsq_setCollectionViewInsetsWithBottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = UIEdgeInsetsMake(self.topLayoutGuide.length, 0.0f, bottom, 0.0f);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}

@end
