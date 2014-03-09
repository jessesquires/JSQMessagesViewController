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

- (void)jsqDemo_setupTestModel;

- (void)jsqDemo_setupViewController;

@end



@implementation JSQDemoViewController


#pragma mark - Initialization

/**
 *  Override point for initializing programmatically
 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self jsqDemo_setupViewController];
    }
    return self;
}

/**
 *  Override point for initializing via storyboards/nibs
 */
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self jsqDemo_setupViewController];
}

- (void)jsqDemo_setupViewController
{
    self.sender = kJSQDemoAvatarNameJesse;
    self.inputToolbar.contentView.textView.placeHolder = NSLocalizedString(@"Message", nil);
    
    JSQMessagesCollectionViewFlowLayout *collectionViewLayout = (JSQMessagesCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    collectionViewLayout.delegate = self;
}

- (void)jsqDemo_setupTestModel
{
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     [[JSQMessage alloc] initWithText:@"Welcome to JSQMessages. Simple, elegant, easy to use." sender:kJSQDemoAvatarNameJesse date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"There are super sweet default settings, but you can customize this like crazy." sender:kJSQDemoAvatarNameWoz date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. \nMy website is www.hexedbits.com." sender:kJSQDemoAvatarNameJesse date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App." sender:kJSQDemoAvatarNameJobs date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"Jony Ive would be so proud." sender:kJSQDemoAvatarNameCook date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Oh, and there's sweet documentation." sender:kJSQDemoAvatarNameJesse date:[NSDate date]],
                     nil];
    
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
    self.avatars = @{
                     kJSQDemoAvatarNameJesse : [[UIImageView alloc] initWithImage:jsqImage],
                     kJSQDemoAvatarNameCook : [[UIImageView alloc] initWithImage:cookImage],
                     kJSQDemoAvatarNameJobs : [[UIImageView alloc] initWithImage:jobsImage],
                     kJSQDemoAvatarNameWoz : [[UIImageView alloc] initWithImage:wozImage]
                     };
    
    //  Change to add more messages for testing
    NSUInteger messagesToAdd = 0;
    for (NSUInteger i = 0; i < messagesToAdd; i++) {
        [self.messages addObjectsFromArray:self.messages];
    }
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"JSQMessages";
    
    [self jsqDemo_setupTestModel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}



#pragma mark - REQUIRED
#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.row];
}


#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.messages count];
}


#pragma mark - JSQMessages CollectionView FlowLayout Delegate

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                         layout:(JSQMessagesCollectionViewFlowLayout *)layout bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                         sender:(NSString *)sender
{
    if ([sender isEqualToString:self.sender]) {
        return [JSQMessagesBubbleImageFactory outgoingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleBlueColor]];
    }
    
    return [JSQMessagesBubbleImageFactory incomingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                         layout:(JSQMessagesCollectionViewFlowLayout *)layout avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                         sender:(NSString *)sender
{
    return [self.avatars objectForKey:sender];
}



#pragma mark - OPTIONAL
#pragma mark - JSQMessages CollectionView FlowLayout Delegate

- (BOOL)collectionView:(JSQMessagesCollectionView *)collectionView
                layout:(JSQMessagesCollectionViewFlowLayout *)layout shouldDisplayTimestampForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)collectionView:(JSQMessagesCollectionView *)collectionView
                layout:(JSQMessagesCollectionViewFlowLayout *)layout shouldDisplaySenderForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                layout:(JSQMessagesCollectionViewFlowLayout *)layout configureItemAtIndexPath:(NSIndexPath *)indexPath
                sender:(NSString *)sender
{
    
}

@end
