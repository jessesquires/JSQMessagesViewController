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

#import "JSQDemoViewController.h"

static NSString * const kJSQDemoAvatarNameJesse = @"Jesse Squires";
static NSString * const kJSQDemoAvatarNameCook = @"Tim Cook";
static NSString * const kJSQDemoAvatarNameJobs = @"Jobs";
static NSString * const kJSQDemoAvatarNameWoz = @"Steve Wozniak";


@interface JSQDemoViewController ()

@property (strong, nonatomic) UIImageView *outgoingBubbleImageView;
@property (strong, nonatomic) UIImageView *incomingBubbleImageView;

- (void)jsqDemo_setupTestModel;

- (void)jsqDemo_receiveMessagePressed:(UIBarButtonItem *)sender;

- (void)jsqDemo_closePressed:(UIBarButtonItem *)sender;

@end



@implementation JSQDemoViewController


#pragma mark - Initialization

/**
 *  Override point for customization
 */
- (void)prepareMessagesViewController
{
    [super prepareMessagesViewController];
    
    self.sender = kJSQDemoAvatarNameJesse;
    self.inputToolbar.contentView.textView.placeHolder = NSLocalizedString(@"Message", nil);
}



#pragma mark - Demo setup

- (void)jsqDemo_setupTestModel
{
    /**
     *  Load some fake messages
     */
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     [[JSQMessage alloc] initWithText:@"Welcome to JSQMessages. Simple, elegant, easy to use." sender:kJSQDemoAvatarNameJesse date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"There are super sweet default settings, but you can customize this like crazy." sender:kJSQDemoAvatarNameWoz date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. \nMy website is www.hexedbits.com." sender:kJSQDemoAvatarNameJesse date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App." sender:kJSQDemoAvatarNameJobs date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"Jony Ive would be so proud." sender:kJSQDemoAvatarNameCook date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Oh, and there's sweet documentation." sender:kJSQDemoAvatarNameJesse date:[NSDate date]],
                     nil];
    
    /**
     *  Create avatar images once and save
     */
    UIImage *jsqImage = [JSQMessagesAvatarFactory avatarWithUserInitials:@"JSQ"
                                                         backgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]
                                                               textColor:[UIColor colorWithWhite:0.60f alpha:1.0f]
                                                                    font:[UIFont systemFontOfSize:14.0f]
                                                                diameter:kJSQMessagesCollectionViewCellAvatarSizeDefault];
    
    UIImage *cookImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_cook"]
                                                          diameter:kJSQMessagesCollectionViewCellAvatarSizeDefault];
    
    UIImage *jobsImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_jobs"]
                                                          diameter:kJSQMessagesCollectionViewCellAvatarSizeDefault];
    
    UIImage *wozImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_woz"]
                                                         diameter:kJSQMessagesCollectionViewCellAvatarSizeDefault];
    self.avatars = @{ kJSQDemoAvatarNameJesse : jsqImage,
                      kJSQDemoAvatarNameCook : cookImage,
                      kJSQDemoAvatarNameJobs : jobsImage,
                      kJSQDemoAvatarNameWoz : wozImage };
    
    /**
     *  Change to add more messages for testing
     */
    NSUInteger messagesToAdd = 0;
    for (NSUInteger i = 0; i < messagesToAdd; i++) {
        [self.messages addObjectsFromArray:self.messages];
    }
    
    /**
     *  Change to YES to add a super long message for testing
     *  You should see "END" twice
     */
    BOOL addREALLYLongMessage = NO;
    if (addREALLYLongMessage) {
        JSQMessage *reallyLongMessage = [JSQMessage messageWithText:@"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END\nSed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END" sender:kJSQDemoAvatarNameJesse];
        [self.messages addObject:reallyLongMessage];
    }
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"JSQMessages";
    
    [self jsqDemo_setupTestModel];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Test Msg"
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(jsqDemo_receiveMessagePressed:)];
    
    /**
     *  Create bubble images once and save
     */
    self.outgoingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    outgoingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleBlueColor]];
    
    self.incomingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    incomingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleGreenColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.delegateModal) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                              target:self
                                                                                              action:@selector(jsqDemo_closePressed:)];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /**
     *  Enable/disable springy bubbles, default is YES.
     *  For best results, toggle from `viewDidAppear:`
     */
    self.collectionViewLayout.springinessEnabled = YES;
}



#pragma mark - Actions

- (void)jsqDemo_receiveMessagePressed:(UIBarButtonItem *)sender
{
    JSQMessage *copyMessage = [[self.messages lastObject] copy];
    NSMutableArray *copyAvatars = [[self.avatars allKeys] mutableCopy];
    [copyAvatars removeObject:kJSQDemoAvatarNameJesse];
    copyMessage.sender = [copyAvatars objectAtIndex:arc4random_uniform((int)[copyAvatars count])];
    
    [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
    [self.messages addObject:copyMessage];
    [self finishSending];
}

- (void)jsqDemo_closePressed:(UIBarButtonItem *)sender
{
    [self.delegateModal didDismissJSQDemoViewController:self];
}



#pragma mark - REQUIRED
#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)sender withMessage:(JSQMessage *)message
{
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    [self.messages addObject:message];
    [self finishSending];
}

- (void)didPressAccessoryButton:(UIButton *)sender
{
    // TODO:
    NSLog(@"Camera pressed!");
}


#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.row];
}


#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                    bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                         sender:(NSString *)sender
{
    /**
     *  Reuse created bubble images, but create new imageView to add to each cell
     *  Otherwise, each cell would be referencing the same imageView and bubbles would disappear from cells
     */
    if ([sender isEqualToString:self.sender]) {
        return [[UIImageView alloc] initWithImage:self.outgoingBubbleImageView.image
                                 highlightedImage:self.outgoingBubbleImageView.highlightedImage];
    }
    
    return [[UIImageView alloc] initWithImage:self.incomingBubbleImageView.image
                             highlightedImage:self.incomingBubbleImageView.highlightedImage];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                    avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                         sender:(NSString *)sender
{
    /**
     *  Reuse created avatar images, but create new imageView to add to each cell
     *  Otherwise, each cell would be referencing the same imageView and avatars would disappear from cells
     */
    UIImage *avatarImage = [self.avatars objectForKey:sender];
    return [[UIImageView alloc] initWithImage:avatarImage];
}







#pragma mark - JSQMessages CollectionView FlowLayout Delegate
//#pragma mark - OPTIONAL
//#pragma mark - JSQMessages CollectionView FlowLayout Delegate
//
//- (NSString *)collectionView:(JSQMessagesCollectionView *)collectionView
//                      layout:(JSQMessagesCollectionViewFlowLayout *)layout cellTopLabelTextForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    // TOOD:
//    return nil;
//}
//
//- (NSString *)collectionView:(JSQMessagesCollectionView *)collectionView
//                      layout:(JSQMessagesCollectionViewFlowLayout *)layout messageBubbleTopLabelTextForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    // TOOD:
//    return nil;
//}
//
//- (NSString *)collectionView:(JSQMessagesCollectionView *)collectionView
//                      layout:(JSQMessagesCollectionViewFlowLayout *)layout cellBottomLabelTextForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    // TOOD:
//    return nil;
//}
//
//- (void)collectionView:(JSQMessagesCollectionView *)collectionView
//                layout:(JSQMessagesCollectionViewFlowLayout *)layout configureItemAtIndexPath:(NSIndexPath *)indexPath
//                sender:(NSString *)sender
//{
//    // TOOD:
//    
//}

@end
