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

@interface JSQMessagesViewController ()

@property (weak, nonatomic) IBOutlet JSQMessagesCollectionView *collectionView;
@property (weak, nonatomic) IBOutlet JSQMessagesInputToolbar *inputToolbar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarHeightContraint;

- (void)updateCollectionViewInsets;
- (void)setCollectionViewInsetsWithBottomValue:(CGFloat)bottom;

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
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateCollectionViewInsets];
    [[JSQMessagesCollectionViewCell appearance] setFont:[UIFont systemFontOfSize:15.0f]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.keyboardTriggerOffset = CGRectGetHeight(self.inputToolbar.bounds);
    
    __weak JSQMessagesViewController *weakSelf = self;
    __weak JSQMessagesInputToolbar *weakInputToolbar = self.inputToolbar;
    
    [self.view addKeyboardPanningWithActionHandler:^(CGRect keyboardFrameInView) {
        CGRect toolbarFrame = weakInputToolbar.frame;
        toolbarFrame.origin.y = CGRectGetMinY(keyboardFrameInView) - CGRectGetHeight(toolbarFrame);
        
        weakInputToolbar.frame = toolbarFrame;
        
        [weakSelf updateCollectionViewInsets];
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view removeKeyboardControl];
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
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.collectionView.collectionViewLayout invalidateLayout];
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
    cell1.textView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    cell1.cellBottomLabel.text = @"sender bottom";
    
    
    cell2.cellTopLabel.text = @"time";
    cell2.messageBubbleTopLabel.text = @"recipient";
    cell2.textView.text = @"other text here";
    cell2.textView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
    cell2.cellBottomLabel.text = @"recipient bottom";
    
    
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
    
    return CGSizeMake(width, 200.0f);
}

#pragma mark - Utilities

- (void)updateCollectionViewInsets
{
    [self setCollectionViewInsetsWithBottomValue:CGRectGetHeight(self.collectionView.frame) - CGRectGetMinY(self.inputToolbar.frame)];
}

- (void)setCollectionViewInsetsWithBottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = UIEdgeInsetsMake(self.topLayoutGuide.length, 0.0f, bottom, 0.0f);
    self.collectionView.contentInset = insets;
    self.collectionView.scrollIndicatorInsets = insets;
}

@end
