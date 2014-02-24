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

@interface JSQMessagesViewController ()

@property (weak, nonatomic) IBOutlet JSQMessagesCollectionView *collectionView;


@end



@implementation JSQMessagesViewController

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Collection view data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessagesCollectionViewCellOutgoing *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier]
                                                                                            forIndexPath:indexPath];
    
    return cell;
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
    return CGSizeMake(layout.itemSize.width, 150.0f);
}

@end
