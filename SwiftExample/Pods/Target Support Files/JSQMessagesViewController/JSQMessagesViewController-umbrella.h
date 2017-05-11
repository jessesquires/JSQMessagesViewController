#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSBundle+JSQMessages.h"
#import "NSString+JSQMessages.h"
#import "UIColor+JSQMessages.h"
#import "UIImage+JSQMessages.h"
#import "UIView+JSQMessages.h"
#import "JSQMessagesViewController.h"
#import "JSQMessagesAvatarImageFactory.h"
#import "JSQMessagesBubbleImageFactory.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"
#import "JSQMessagesTimestampFormatter.h"
#import "JSQMessagesToolbarButtonFactory.h"
#import "JSQMessagesVideoThumbnailFactory.h"
#import "JSQMessages.h"
#import "JSQAudioMediaViewAttributes.h"
#import "JSQMessagesBubbleSizeCalculating.h"
#import "JSQMessagesBubblesSizeCalculator.h"
#import "JSQMessagesCollectionViewFlowLayout.h"
#import "JSQMessagesCollectionViewFlowLayoutInvalidationContext.h"
#import "JSQMessagesCollectionViewLayoutAttributes.h"
#import "JSQAudioMediaItem.h"
#import "JSQLocationMediaItem.h"
#import "JSQMediaItem.h"
#import "JSQMessage.h"
#import "JSQMessageAvatarImageDataSource.h"
#import "JSQMessageBubbleImageDataSource.h"
#import "JSQMessageData.h"
#import "JSQMessageMediaData.h"
#import "JSQMessagesAvatarImage.h"
#import "JSQMessagesBubbleImage.h"
#import "JSQMessagesCollectionViewDataSource.h"
#import "JSQMessagesCollectionViewDelegateFlowLayout.h"
#import "JSQMessagesViewAccessoryButtonDelegate.h"
#import "JSQPhotoMediaItem.h"
#import "JSQVideoMediaItem.h"
#import "JSQMessagesCellTextView.h"
#import "JSQMessagesCollectionView.h"
#import "JSQMessagesCollectionViewCell.h"
#import "JSQMessagesCollectionViewCellIncoming.h"
#import "JSQMessagesCollectionViewCellOutgoing.h"
#import "JSQMessagesComposerTextView.h"
#import "JSQMessagesInputToolbar.h"
#import "JSQMessagesLabel.h"
#import "JSQMessagesLoadEarlierHeaderView.h"
#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesToolbarContentView.h"
#import "JSQMessagesTypingIndicatorFooterView.h"
#import "JSQMessagesTypingView.h"

FOUNDATION_EXPORT double JSQMessagesViewControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char JSQMessagesViewControllerVersionString[];

