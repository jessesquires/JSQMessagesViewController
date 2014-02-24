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
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
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

@end


/*
- (void)setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor rs_activityBackgroundColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[RSCollectionActivityInstructionHeaderView nib]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:NSStringFromClass([RSCollectionActivityInstructionHeaderView class])];
    
    LXReorderableCollectionViewFlowLayout *collectionViewLayout = (LXReorderableCollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    collectionViewLayout.panGestureRecognizer.maximumNumberOfTouches = 1;
    collectionViewLayout.longPressGestureRecognizer.minimumPressDuration = 0.2;
    collectionViewLayout.longPressGestureRecognizer.numberOfTouchesRequired = 1;
    collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGFloat spacing = 10.0f;
    collectionViewLayout.itemSize = CGSizeMake(self.collectionView.frame.size.width - (spacing * 2.0f), 0.0f);
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(spacing, spacing, spacing, spacing);
    collectionViewLayout.minimumInteritemSpacing = spacing;
    collectionViewLayout.minimumLineSpacing = spacing;
}
 */
