//
//  Created by Jesse Squires
//  http://www.hexedbits.com
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

#import "JSQDemoViewController.h"

#import "JSQMessagesThumbnailFactory.h"
#import "JSQMessagesActivityIndicatorView.h"
#import "JSQAudioPlayerView.h"


static NSString * const kJSQDemoAvatarNameCook = @"Tim Cook";
static NSString * const kJSQDemoAvatarNameJobs = @"Jobs";
static NSString * const kJSQDemoAvatarNameWoz = @"Steve Wozniak";
static NSString * const kJSQDemoVideoMessageURLString = @"https://archive.org/download/AppleAds/Apple-Icloud-TvAd-IcloudHarmony.mp4";
static NSString * const kJSQDemoAudioMessageURLString = @"https://ia700304.us.archive.org/9/items/FurElise_656/FurElise_64kb.mp3";

@implementation JSQDemoViewController

#pragma mark - Demo setup

- (void)setupTestModel
{
    /**
     *  Load some fake messages for demo.
     *
     *  You should have a mutable array or orderedSet, or something.
     */
    
    UIImage *placeholderImage = [UIImage imageNamed:@"demo_image_placeholder"];
    UIImage *videoPlaceholderImage = [UIImage imageNamed:@"demo_video_placeholder"];
    NSURL *localAudioURL = [[NSBundle mainBundle] URLForResource:@"demo_for_Elise" withExtension:@"mp3"];
    
    self.messages = [[NSMutableArray alloc] initWithObjects:
                     [[JSQMessage alloc] initWithText:@"Welcome to JSQMessages: A messaging UI framework for iOS." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It is simple, elegant, and easy to use. There are super sweet default settings, but you can customize like crazy." sender:kJSQDemoAvatarNameWoz date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"It even has data detectors. You can call me tonight. My cell number is 123-456-7890. My website is www.hexedbits.com." sender:self.sender date:[NSDate distantPast]],
                     [[JSQMessage alloc] initWithText:@"JSQMessagesViewController is nearly an exact replica of the iOS Messages App. And perhaps, better." sender:kJSQDemoAvatarNameJobs date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"It is unit-tested, free, and open-source." sender:kJSQDemoAvatarNameCook date:[NSDate date]],
                     [[JSQMessage alloc] initWithText:@"Oh, and there's sweet documentation." sender:self.sender date:[NSDate date]],
                     
                     [JSQMessage messageWithImageURL:[NSURL URLWithString:@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage005.jpg"]
                                    placeholderImage:placeholderImage sender:kJSQDemoAvatarNameWoz],
                     [JSQMessage messageWithImageURL:[NSURL URLWithString:@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage015.jpg"]
                                    placeholderImage:placeholderImage sender:kJSQDemoAvatarNameWoz],
                     [JSQMessage messageWithImageURL:[NSURL URLWithString:@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage016.jpg"]
                                    placeholderImage:placeholderImage sender:kJSQDemoAvatarNameWoz],
                     [JSQMessage messageWithImageURL:[NSURL URLWithString:@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage017.jpg"]
                                    placeholderImage:placeholderImage sender:self.sender],
                     
                     [JSQMessage messageWithImage:[UIImage imageNamed:@"FICDDemoLargeImage000"]
                                   thumbnailImage:[UIImage imageNamed:@"FICDDemoSmallImage000"] sender:self.sender],
                     [JSQMessage messageWithImage:[UIImage imageNamed:@"FICDDemoLargeImage001"]
                                   thumbnailImage:[UIImage imageNamed:@"FICDDemoSmallImage001"] sender:kJSQDemoAvatarNameJobs],
                     [JSQMessage messageWithImage:[UIImage imageNamed:@"FICDDemoLargeImage002"]
                                   thumbnailImage:[UIImage imageNamed:@"FICDDemoSmallImage002"] sender:self.sender],
                     [JSQMessage messageWithImage:[UIImage imageNamed:@"FICDDemoLargeImage003"]
                                   thumbnailImage:[UIImage imageNamed:@"FICDDemoSmallImage003"] sender:kJSQDemoAvatarNameWoz],
                     [JSQMessage messageWithVideoURL:[NSURL URLWithString:kJSQDemoVideoMessageURLString] placeholderImage:videoPlaceholderImage sender:kJSQDemoAvatarNameWoz],
                     [JSQMessage messageWithVideoURL:[NSURL URLWithString:kJSQDemoVideoMessageURLString] placeholderImage:videoPlaceholderImage sender:self.sender],
                     
                     [JSQMessage messageWithAudio:[NSData dataWithContentsOfURL:localAudioURL] sender:self.sender],
                     [JSQMessage messageWithAudioURL:localAudioURL sender:kJSQDemoAvatarNameWoz],
                     [JSQMessage messageWithAudioURL:[NSURL URLWithString:kJSQDemoAudioMessageURLString] sender:kJSQDemoAvatarNameCook],
                     nil];
    
    /**
     *    Add a local video message.
     */
    NSURL *localVideoURL = [[NSBundle mainBundle] URLForResource:@"demo_video" withExtension:@"mp4"];
    [self.messages addObject:[JSQMessage messageWithVideoURL:localVideoURL thumbnail:[UIImage imageNamed:@"demo_video_thumbnail"] sender:self.sender]];
    
    /**
     *  Create avatar images once.
     *
     *  Be sure to create your avatars one time and reuse them for good performance.
     *
     *  If you are not using avatars, ignore this.
     */
    CGFloat outgoingDiameter = self.collectionView.collectionViewLayout.outgoingAvatarViewSize.width;
    
    UIImage *jsqImage = [JSQMessagesAvatarFactory avatarWithUserInitials:@"JSQ"
                                                         backgroundColor:[UIColor colorWithWhite:0.85f alpha:1.0f]
                                                               textColor:[UIColor colorWithWhite:0.60f alpha:1.0f]
                                                                    font:[UIFont systemFontOfSize:14.0f]
                                                                diameter:outgoingDiameter];
    
    CGFloat incomingDiameter = self.collectionView.collectionViewLayout.incomingAvatarViewSize.width;
    
    UIImage *cookImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_cook"]
                                                          diameter:incomingDiameter];
    
    UIImage *jobsImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_jobs"]
                                                          diameter:incomingDiameter];
    
    UIImage *wozImage = [JSQMessagesAvatarFactory avatarWithImage:[UIImage imageNamed:@"demo_avatar_woz"]
                                                         diameter:incomingDiameter];
    self.avatars = @{ self.sender : jsqImage,
                      kJSQDemoAvatarNameCook : cookImage,
                      kJSQDemoAvatarNameJobs : jobsImage,
                      kJSQDemoAvatarNameWoz : wozImage };
    
    /**
     *  Change to add more messages for testing
     */
    NSUInteger messagesToAdd = 1;
    NSArray *copyOfMessages = [self.messages copy];
    for (NSUInteger i = 0; i < messagesToAdd; i++) {
        [self.messages addObjectsFromArray:copyOfMessages];
    }
    
    /**
     *  Change to YES to add a super long message for testing
     *  You should see "END" twice
     */
    BOOL addREALLYLongMessage = NO;
    if (addREALLYLongMessage) {
        JSQMessage *reallyLongMessage = [JSQMessage messageWithText:@"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? END" sender:self.sender];
        [self.messages addObject:reallyLongMessage];
    }
}



#pragma mark - View lifecycle

/**
 *  Override point for customization.
 *
 *  Customize your view.
 *  Look at the properties on `JSQMessagesViewController` to see what is possible.
 *
 *  Customize your layout.
 *  Look at the properties on `JSQMessagesCollectionViewFlowLayout` to see what is possible.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.title = @"JSQMessages";
    
    self.sender = @"Jesse Squires";
    
    [self setupTestModel];
    
    
//    self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
//    self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
//    self.collectionView.collectionViewLayout.incomingThumbnailImageSize = CGSizeMake(100, 100);
//    self.collectionView.collectionViewLayout.outgoingThumbnailImageSize = CGSizeMake(200, 200);
//    self.collectionView.collectionViewLayout.incomingVideoOverlayViewSize = CGSizeMake(80, 80);
//    self.collectionView.collectionViewLayout.outgoingVideoOverlayViewSize = CGSizeMake(120, 120);
    
    self.collectionView.collectionViewLayout.messageBubbleFont = [UIFont fontWithName:@"AvenirNextCondensed-Regular" size:18.f];

    /**
     *  Remove camera button since media messages are not yet implemented
     *
     *   self.inputToolbar.contentView.leftBarButtonItem = nil;
     *
     *  Or, you can set a custom `leftBarButtonItem` and a custom `rightBarButtonItem`
     */
    
    /**
     *  Create bubble images.
     *
     *  Be sure to create your avatars one time and reuse them for good performance.
     *
     */
    self.outgoingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    outgoingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    
    self.incomingBubbleImageView = [JSQMessagesBubbleImageFactory
                                    incomingMessageBubbleImageViewWithColor:[UIColor jsq_messageBubbleGreenColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"typing"]
                                                                              style:UIBarButtonItemStyleBordered
                                                                             target:self
                                                                             action:@selector(receiveMessagePressed:)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.delegateModal) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                              target:self
                                                                                              action:@selector(closePressed:)];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /**
     *  Enable/disable springy bubbles, default is YES.
     *  For best results, toggle from `viewDidAppear:`
     */
    self.collectionView.collectionViewLayout.springinessEnabled = YES;
}



#pragma mark - Actions

- (void)receiveMessagePressed:(UIBarButtonItem *)sender
{
    /**
     *  The following is simply to simulate received messages for the demo.
     *  Do not actually do this.
     */
    
    
    /**
     *  Show the tpying indicator
     */
    self.showTypingIndicator = !self.showTypingIndicator;
    
    JSQMessage *copyMessage = [[self.messages lastObject] copy];
    
    if (!copyMessage) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *copyAvatars = [[self.avatars allKeys] mutableCopy];
        [copyAvatars removeObject:self.sender];
        copyMessage.sender = [copyAvatars objectAtIndex:arc4random_uniform((int)[copyAvatars count])];
        
        /**
         *  This you should do upon receiving a message:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishReceivingMessage`
         */
        [JSQSystemSoundPlayer jsq_playMessageReceivedSound];
        [self.messages addObject:copyMessage];
        [self finishReceivingMessage];
    });
}

- (void)closePressed:(UIBarButtonItem *)sender
{
    [self.delegateModal didDismissJSQDemoViewController:self];
}




#pragma mark - JSQMessagesViewController method overrides

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                    sender:(NSString *)sender
                      date:(NSDate *)date
{
    /**
     *  Sending a message. Your implementation of this method should do *at least* the following:
     *
     *  1. Play sound (optional)
     *  2. Add new id<JSQMessageData> object to your data source
     *  3. Call `finishSendingMessage`
     */
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    
    JSQMessage *message = [[JSQMessage alloc] initWithText:text sender:sender date:date];
    [self.messages addObject:message];
    
    [self finishSendingMessage];
}

- (void)didPressAccessoryButton:(UIButton *)sensder
{
    NSLog(@"Camera pressed!");
    /**
     *  Accessory button has no default functionality, yet.
     */
}



#pragma mark - JSQMessages CollectionView DataSource

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.item];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  You may return nil here if you do not want bubbles.
     *  In this case, you should set the background color of your collection view cell's textView.
     */
    
    /**
     *  Reuse created bubble images, but create new imageView to add to each cell
     *  Otherwise, each cell would be referencing the same imageView and bubbles would disappear from cells
     */
    
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    if ([message.sender isEqualToString:self.sender]) {
        return [[UIImageView alloc] initWithImage:self.outgoingBubbleImageView.image
                                 highlightedImage:self.outgoingBubbleImageView.highlightedImage];
    }
    
    return [[UIImageView alloc] initWithImage:self.incomingBubbleImageView.image
                             highlightedImage:self.incomingBubbleImageView.highlightedImage];
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Return `nil` here if you do not want avatars.
     *  If you do return `nil`, be sure to do the following in `viewDidLoad`:
     *
     *  self.collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero;
     *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero;
     *
     *  It is possible to have only outgoing avatars or only incoming avatars, too.
     */
    
    /**
     *  Reuse created avatar images, but create new imageView to add to each cell
     *  Otherwise, each cell would be referencing the same imageView and avatars would disappear from cells
     *
     *  Note: these images will be sized according to these values:
     *
     *  self.collectionView.collectionViewLayout.incomingAvatarViewSize
     *  self.collectionView.collectionViewLayout.outgoingAvatarViewSize
     *
     *  Override the defaults in `viewDidLoad`
     */
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    UIImage *avatarImage = [self.avatars objectForKey:message.sender];
    return [[UIImageView alloc] initWithImage:avatarImage];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
     *  The other label text delegate methods should follow a similar pattern.
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
        return [[JSQMessagesTimestampFormatter sharedFormatter] attributedTimestampForDate:message.date];
    }
    
    return nil;
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    
    /**
     *  iOS7-style sender name labels
     */
    if ([message.sender isEqualToString:self.sender]) {
        return nil;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:message.sender]) {
            return nil;
        }
    }
    
    /**
     *  Don't specify attributes to use the defaults.
     */
    return [[NSAttributedString alloc] initWithString:message.sender];
}

- (NSAttributedString *)collectionView:(JSQMessagesCollectionView *)collectionView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (UIView *)collectionView:(JSQMessagesCollectionView *)collectionView viewForVideoOverlayViewAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Return `nil` here if you do not want overlay view for incoming video message.
     *  If you do return `nil`, be sure to do the following in `viewDidLoad`:
     *
     *  self.collectionView.collectionViewLayout.incomingVideoOverlayViewSize = CGSizeZero;
     */
    
    /**
     *  You should create new view to add to each cell
     *  Otherwise, each cell would be referencing the same view.
     *
     *  Note: these views will be sized according to these values:
     *
     *  self.collectionView.collectionViewLayout.incomingVideoOverlayViewSize
     *
     *  Override the defaults in `viewDidLoad`
     */
    
    UIImageView *incomingVideoOverlayView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo_play_button_in"] highlightedImage:nil];
    return incomingVideoOverlayView;
}

- (UIView *)collectionView:(JSQMessagesCollectionView *)collectionView outgoingVideoOverlayViewForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Return `nil` here if you do not want overlay view for outgoing video message.
     *  If you do return `nil`, be sure to do the following in `viewDidLoad`:
     *
     *  self.collectionView.collectionViewLayout.outgoingVideoOverlayViewSize = CGSizeZero;
     */
    
    /**
     *  You should create new view to add to each cell
     *  Otherwise, each cell would be referencing the same view.
     *
     *  Note: these views will be sized according to these values:
     *
     *  self.collectionView.collectionViewLayout.outgoingVideoOverlayViewSize
     *
     *  Override the defaults in `viewDidLoad`
     */
    UIImageView *outgoingVideoOverlayView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo_play_button_out"] highlightedImage:nil];
    return outgoingVideoOverlayView;
}

- (UIView *)collectionView:(JSQMessagesCollectionView *)collectionView viewForAudioPlayerViewAtIndexPath:(NSIndexPath *)indexPath
{
    return [[JSQAudioPlayerView alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
}

- (UIView <JSQMessagesActivityIndicator> *)collectionView:(JSQMessagesCollectionView *)collectionView viewForPhotoActivityIndicatorViewAtIndexPath:(NSIndexPath *)indexPath
{
    return [JSQMessagesActivityIndicatorView new];
}


- (UIView <JSQMessagesActivityIndicator> *)collectionView:(JSQMessagesCollectionView *)collectionView viewForVideoActivityIndicatorViewAtIndexPath:(NSIndexPath *)indexPath
{
    return [JSQMessagesActivityIndicatorView new];
}

- (UIView<JSQMessagesActivityIndicator> *)collectionView:(JSQMessagesCollectionView *)collectionView viewForAudioActivityIndicatorViewAtIndexPath:(NSIndexPath *)indexPath
{
    return [JSQMessagesActivityIndicatorView new];
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
  wantsThumbnailForURL:(NSURL *)sourceURL thumbnailImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
       completionBlock:(JSQMessagesCollectionViewDataSourceCompletionBlock)completionBlock {
    
    JSQMessage *message = self.messages[indexPath.item];
    BOOL isOutgoingMessage = [[message sender] isEqualToString:self.sender];
    
    /**
     *  Here you can download images from the Internet.
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *thumbnail = nil;
        
        if (message.type == JSQMessageRemotePhoto) {
            NSData *imageData = [NSData dataWithContentsOfURL:sourceURL];
            
            if (imageData) {
                UIImage *sourceImage = [UIImage imageWithData:imageData];
                message.sourceImage = sourceImage;
                
                /**
                 *  Before the image display you should generate a thumbnail to improve performance.
                 */
                CGFloat screenScale = [[UIScreen mainScreen] scale];
                CGSize mediaImageViewSize = isOutgoingMessage
                ? collectionView.collectionViewLayout.outgoingThumbnailImageSize
                : collectionView.collectionViewLayout.incomingThumbnailImageSize;
                
                CGRect contextBounds = CGRectMake(0.f, 0.f, mediaImageViewSize.width * screenScale, mediaImageViewSize.height * screenScale);
                
                UIGraphicsBeginImageContext(contextBounds.size);
                [sourceImage drawInRect:contextBounds];
                thumbnail = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                
                message.thumbnailImage = thumbnail;
                message.type = JSQMessagePhoto;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(thumbnail);
                });
            }
            else {
                NSLog(@"Error, Can not download image for URL:%@", message.sourceURL);
            }
        }
        else if (message.type == JSQMessageRemoteVideo) {
            
            /**
             *  Generate thumbnails from remote url.
             */
            UIImage *remoteThumbnail = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:sourceURL];
            
            /**
             *  May not support this format or video encoding is incorrect.
             */
            if (!remoteThumbnail) {
                NSLog(@"Error, Can not generate thumbnail for URL: %@", sourceURL);
            }
            else {
                thumbnail = remoteThumbnail;
                
                message.videoThumbnail = remoteThumbnail;
                message.videoThumbnailPlaceholder = nil;
                
                /**
                 *  Change the message type, so next time we will not need to ask the data source method.
                 */
                message.type = JSQMessageVideo;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completionBlock(thumbnail);
                });
            }
        }
    });
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.messages count];
}

- (UICollectionViewCell *)collectionView:(JSQMessagesCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Override point for customizing cells
     */
    JSQMessagesCollectionViewCell *cell = (JSQMessagesCollectionViewCell *)[super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    
    /**
     *  Configure almost *anything* on the cell
     *  
     *  Text colors, label text, label colors, etc.
     *
     *
     *  DO NOT set `cell.textView.font` !
     *  Instead, you need to set `self.collectionView.collectionViewLayout.messageBubbleFont` to the font you want in `viewDidLoad`
     *
     *  
     *  DO NOT manipulate cell layout information!
     *  Instead, override the properties you want on `self.collectionView.collectionViewLayout` from `viewDidLoad`
     */
    
    JSQMessage *msg = [self.messages objectAtIndex:indexPath.item];
    
    if (cell.textView) {
        if ([msg.sender isEqualToString:self.sender]) {
            cell.textView.textColor = [UIColor blackColor];
        }
        else {
            cell.textView.textColor = [UIColor whiteColor];
        }
        
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    }
    
    return cell;
}


#pragma mark - JSQMessages collection view flow layout delegate

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
     */
    
    /**
     *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
     *  The other label height delegate methods should follow similarly
     *
     *  Show a timestamp for every 3rd message
     */
    if (indexPath.item % 3 == 0) {
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }
    
    return 0.0f;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  iOS7-style sender name labels
     */
    JSQMessage *currentMessage = [self.messages objectAtIndex:indexPath.item];
    if ([[currentMessage sender] isEqualToString:self.sender]) {
        return 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        JSQMessage *previousMessage = [self.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage sender] isEqualToString:[currentMessage sender]]) {
            return 0.0f;
        }
    }
    
    return kJSQMessagesCollectionViewCellLabelHeightDefault;
}

- (CGFloat)collectionView:(JSQMessagesCollectionView *)collectionView
                   layout:(JSQMessagesCollectionViewFlowLayout *)collectionViewLayout heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.0f;
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView
                header:(JSQMessagesLoadEarlierHeaderView *)headerView didTapLoadEarlierMessagesButton:(UIButton *)sender
{
    NSLog(@"Load earlier messages!");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapPhoto:(UIImageView *)imageView atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapVideoForURL:(NSURL *)videoURL atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapAudio:(NSData *)audioData atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"");
}

- (void)collectionView:(JSQMessagesCollectionView *)collectionView didTapAudioForURL:(NSURL *)audioURL atIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"");
}


@end
