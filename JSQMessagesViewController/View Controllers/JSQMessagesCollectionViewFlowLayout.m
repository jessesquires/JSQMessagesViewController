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
//
//
//  Initial code for springy collection view layout taken from Ash Furrow
//  ASHSpringyCollectionView
//
//  The MIT License
//  Copyright (c) 2013 Ash Furrow
//  https://github.com/AshFurrow/ASHSpringyCollectionView
//

#import "JSQMessagesCollectionViewFlowLayout.h"

#import "JSQMessagesCollectionViewLayoutAttributes.h"


@interface JSQMessagesCollectionViewFlowLayout ()

@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) NSMutableSet *visibleIndexPaths;
@property (assign, nonatomic) UIInterfaceOrientation interfaceOrientation;
@property (assign, nonatomic) CGFloat latestDelta;

- (UIAttachmentBehavior *)jsq_springBehaviorWithLayoutAttributesItem:(UICollectionViewLayoutAttributes *)item;

- (void)jsq_addNewlyVisibleBehaviorsFromVisibleItems:(NSArray *)visibleItems;

- (void)jsq_removeNoLongerVisibleBehaviorsFromVisibleItemsIndexPaths:(NSSet *)visibleItemsIndexPaths;

- (void)jsq_adjustSpringBehavior:(UIAttachmentBehavior *)springBehavior forTouchLocation:(CGPoint)touchLocation;

@end



@implementation JSQMessagesCollectionViewFlowLayout

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _springinessEnabled = NO;
    
    self.dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
    self.visibleIndexPaths = [[NSMutableSet alloc] init];
    self.springResistanceFactor = 800;
}

+ (Class)layoutAttributesClass
{
    return [JSQMessagesCollectionViewLayoutAttributes class];
}

#pragma mark - Setters

- (void)setSpringinessEnabled:(BOOL)springinessEnabled
{
    _springinessEnabled = springinessEnabled;
    [self invalidateLayout];
    
    if (!springinessEnabled) {
        [self.dynamicAnimator removeAllBehaviors];
        [self.visibleIndexPaths removeAllObjects];
    }
}

#pragma mark - Collection view flow layout

- (void)prepareLayout
{
    [super prepareLayout];
    
    if ([UIApplication sharedApplication].statusBarOrientation != self.interfaceOrientation) {
        [self.dynamicAnimator removeAllBehaviors];
        [self.visibleIndexPaths removeAllObjects];
    }
    
    self.interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (self.springinessEnabled) {
        //  pad rect to avoid flickering
        CGFloat padding = -100.0f;
        CGRect visibleRect = CGRectInset(self.collectionView.bounds, padding, padding);
        
        NSArray *visibleItems = [super layoutAttributesForElementsInRect:visibleRect];
        NSSet *visibleItemsIndexPaths = [NSSet setWithArray:[visibleItems valueForKey:NSStringFromSelector(@selector(indexPath))]];
        
        [self jsq_removeNoLongerVisibleBehaviorsFromVisibleItemsIndexPaths:visibleItemsIndexPaths];
        
        [self jsq_addNewlyVisibleBehaviorsFromVisibleItems:visibleItems];
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSLog(@"LAYOUT RECT");
    NSArray *attributes;
    
    if (self.springinessEnabled) {
        attributes = [self.dynamicAnimator itemsInRect:rect];
    }
    else {
        attributes = [super layoutAttributesForElementsInRect:rect];
    }
    
    [attributes enumerateObjectsUsingBlock:^(JSQMessagesCollectionViewLayoutAttributes *attributes, NSUInteger idx, BOOL *stop) {
//        attributes.backgroundColor = [UIColor purpleColor];
    }];
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"ATTRRS INDEX");
    
    UICollectionViewLayoutAttributes *layoutAttributes;
    
    if (self.springinessEnabled) {
        layoutAttributes = [self.dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
    }
    else {
        layoutAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    }
    
    JSQMessagesCollectionViewLayoutAttributes *customAttributes = (JSQMessagesCollectionViewLayoutAttributes *)layoutAttributes;
    
    return customAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    if (self.springinessEnabled) {
        UIScrollView *scrollView = self.collectionView;
        CGFloat delta = newBounds.origin.y - scrollView.bounds.origin.y;
        
        self.latestDelta = delta;
        
        CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
        
        [self.dynamicAnimator.behaviors enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger idx, BOOL *stop) {
            [self jsq_adjustSpringBehavior:springBehaviour forTouchLocation:touchLocation];
            [self.dynamicAnimator updateItemUsingCurrentState:[springBehaviour.items firstObject]];
        }];
    }
    
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

- (void)prepareForCollectionViewUpdates:(NSArray *)updateItems
{
    [super prepareForCollectionViewUpdates:updateItems];
    
    if (self.springinessEnabled) {
        [updateItems enumerateObjectsUsingBlock:^(UICollectionViewUpdateItem *updateItem, NSUInteger index, BOOL *stop) {
            if (updateItem.updateAction == UICollectionUpdateActionInsert) {
                
                if ([self.dynamicAnimator layoutAttributesForCellAtIndexPath:updateItem.indexPathAfterUpdate]) {
                    *stop = YES;
                }
                
                CGSize size = self.collectionView.bounds.size;
                UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:updateItem.indexPathAfterUpdate];
                attributes.frame = CGRectMake(0.0f,
                                              size.height - size.width,
                                              size.width,
                                              size.width);
                
                UIAttachmentBehavior *springBehaviour = [self jsq_springBehaviorWithLayoutAttributesItem:attributes];
                [self.dynamicAnimator addBehavior:springBehaviour];
            }
        }];
    }
}

#pragma mark - Spring behavior utilities

- (UIAttachmentBehavior *)jsq_springBehaviorWithLayoutAttributesItem:(UICollectionViewLayoutAttributes *)item
{
    UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
    springBehavior.length = 1.0f;
    springBehavior.damping = 0.8f;
    springBehavior.frequency = 1.0f;
    return springBehavior;
}

- (void)jsq_addNewlyVisibleBehaviorsFromVisibleItems:(NSArray *)visibleItems
{
    //  a "newly visible" item is in `visibleItems` but not in `self.visibleIndexPaths`
    NSIndexSet *indexSet = [visibleItems indexesOfObjectsWithOptions:NSEnumerationConcurrent
                                                         passingTest:^BOOL(UICollectionViewLayoutAttributes *item, NSUInteger index, BOOL *stop) {
                                                             return ![self.visibleIndexPaths containsObject:item.indexPath];
                                                         }];
    
    NSArray *newlyVisibleItems = [visibleItems objectsAtIndexes:indexSet];
    
    CGPoint touchLocation = [self.collectionView.panGestureRecognizer locationInView:self.collectionView];
    
    [newlyVisibleItems enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *item, NSUInteger index, BOOL *stop) {
        UIAttachmentBehavior *springBehaviour = [self jsq_springBehaviorWithLayoutAttributesItem:item];
        [self jsq_adjustSpringBehavior:springBehaviour forTouchLocation:touchLocation];
        [self.dynamicAnimator addBehavior:springBehaviour];
        [self.visibleIndexPaths addObject:item.indexPath];
    }];
}

- (void)jsq_removeNoLongerVisibleBehaviorsFromVisibleItemsIndexPaths:(NSSet *)visibleItemsIndexPaths
{
    NSArray *behaviors = self.dynamicAnimator.behaviors;
    NSIndexSet *indexSet = [behaviors indexesOfObjectsWithOptions:NSEnumerationConcurrent
                                                      passingTest:^BOOL(UIAttachmentBehavior *springBehaviour, NSUInteger index, BOOL *stop) {
                                                          UICollectionViewLayoutAttributes *layoutAttributes = [springBehaviour.items firstObject];
                                                          return ![visibleItemsIndexPaths containsObject:layoutAttributes.indexPath];
                                                      }];
    NSArray *behaviorsToRemove = [self.dynamicAnimator.behaviors objectsAtIndexes:indexSet];
    
    [behaviorsToRemove enumerateObjectsUsingBlock:^(UIAttachmentBehavior *springBehaviour, NSUInteger index, BOOL *stop) {
        UICollectionViewLayoutAttributes *layoutAttributes = [springBehaviour.items firstObject];
        [self.dynamicAnimator removeBehavior:springBehaviour];
        [self.visibleIndexPaths removeObject:layoutAttributes.indexPath];
    }];
}

- (void)jsq_adjustSpringBehavior:(UIAttachmentBehavior *)springBehavior forTouchLocation:(CGPoint)touchLocation
{
    UICollectionViewLayoutAttributes *item = [springBehavior.items firstObject];
    CGPoint center = item.center;
    
    //  if touch is not (0,0) -- adjust item center "in flight"
    if (!CGPointEqualToPoint(CGPointZero, touchLocation)) {
        CGFloat distanceFromTouch = fabsf(touchLocation.y - springBehavior.anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / self.springResistanceFactor;
        
        if (self.latestDelta < 0.0f) {
            center.y += MAX(self.latestDelta, self.latestDelta * scrollResistance);
        }
        else {
            center.y += MIN(self.latestDelta, self.latestDelta * scrollResistance);
        }
        item.center = center;
    }
}

@end
