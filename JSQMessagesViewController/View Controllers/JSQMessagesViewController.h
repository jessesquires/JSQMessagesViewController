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

#import <UIKit/UIKit.h>

#import "JSQMessagesCollectionView.h"
#import "JSQMessagesCollectionViewFlowLayout.h"
#import "JSQMessagesCollectionViewCellIncoming.h"
#import "JSQMessagesCollectionViewCellOutgoing.h"

#import "JSQMessagesToolbarContentView.h"
#import "JSQMessagesInputToolbar.h"
#import "JSQMessagesComposerTextView.h"

#import "JSQMessageData.h"

#import "JSQMessagesBubbleImageFactory.h"
#import "JSQMessagesAvatarFactory.h"

#import "JSQSystemSoundPlayer+JSQMessages.h"
#import "UIColor+JSQMessages.h"
#import "UIImage+JSQMessages.h"
#import "UIView+JSQMessages.h"


@interface JSQMessagesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic, readonly) JSQMessagesCollectionView *collectionView;

@property (weak, nonatomic, readonly) JSQMessagesInputToolbar *inputToolbar;

#pragma mark - Class methods

+ (UIStoryboard *)messagesStoryboard;

+ (JSQMessagesViewController *)messagesViewController;

@end
