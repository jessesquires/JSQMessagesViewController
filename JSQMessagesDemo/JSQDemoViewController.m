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


@interface JSQDemoViewController ()

@end



@implementation JSQDemoViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"JSQMessages";
    
//    JSQMessagesCollectionViewFlowLayout *collectionViewLayout = (JSQMessagesCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
//    collectionViewLayout.delegate = self;
}

#pragma mark - JSQMessages data source

- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - JSQMessages collectionView flowLayout delegate

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                         layout:(JSQMessagesCollectionViewFlowLayout *)layout bubbleImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                         sender:(NSString *)sender
{
    return nil;
}

- (UIImageView *)collectionView:(JSQMessagesCollectionView *)collectionView
                         layout:(JSQMessagesCollectionViewFlowLayout *)layout avatarImageViewForItemAtIndexPath:(NSIndexPath *)indexPath
                         sender:(NSString *)sender
{
    return nil;
}

@end
