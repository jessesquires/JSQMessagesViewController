//
//  Created by Jesse Squires
//  http://www.jessesquires.com
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

#import "JSQLocationMediaItem.h"

#import "JSQMessagesMediaPlaceholderView.h"
#import "JSQMessagesMediaViewBubbleImageMasker.h"


@interface JSQLocationMediaItem ()

@property (strong, nonatomic) UIImage *cachedMapSnapshotImage;
@property (assign, nonatomic) CGSize viewSize;

@end


@implementation JSQLocationMediaItem

@synthesize cachedMediaView = _cachedMediaView;
#pragma mark - Initialization

- (instancetype)initWithLocation:(CLLocation *)location
{
    self = [super init];
    if (self) {
        [self setLocation:location withCompletionHandler:nil];
    }
    return self;
}

#pragma mark - Setters

- (void)setLocation:(CLLocation *)location
{
    [self setLocation:location withCompletionHandler:nil];
}

- (void)setAppliesMediaViewMaskAsOutgoing:(BOOL)appliesMediaViewMaskAsOutgoing
{
    [super setAppliesMediaViewMaskAsOutgoing:appliesMediaViewMaskAsOutgoing];
    _cachedMapSnapshotImage = nil;
}

#pragma mark - Map snapshot

- (void)setLocation:(CLLocation *)location withCompletionHandler:(JSQLocationMediaItemCompletionBlock)completion
{
    [self setLocation:location region:MKCoordinateRegionMakeWithDistance(location.coordinate, 500.0, 500.0) withCompletionHandler:completion];
}

- (void)setLocation:(CLLocation *)location region:(MKCoordinateRegion)region withCompletionHandler:(JSQLocationMediaItemCompletionBlock)completion
{
    _location = [location copy];
    _cachedMapSnapshotImage = nil;
    _cachedMediaView = nil;
    
    if (_location == nil) {
        return;
    }
    
    [self createMapViewSnapshotForLocation:_location
                          coordinateRegion:region
                     withCompletionHandler:completion];
}

- (void)createMapViewSnapshotForLocation:(CLLocation *)location
                        coordinateRegion:(MKCoordinateRegion)region
                   withCompletionHandler:(JSQLocationMediaItemCompletionBlock)completion
{
    NSParameterAssert(location != nil);
    
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    options.region = region;
    if (!CGSizeEqualToSize(self.viewSize, CGSizeZero)) {
        options.size = self.viewSize;
    }
    
    MKMapSnapshotter *snapShotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    
    [snapShotter startWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
              completionHandler:^(MKMapSnapshot *snapshot, NSError *error) {
                  if (error) {
                      NSLog(@"%s Error creating map snapshot: %@", __PRETTY_FUNCTION__, error);
                      return;
                  }
                  
                  MKAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:nil];
                  CGPoint coordinatePoint = [snapshot pointForCoordinate:location.coordinate];
                  UIImage *image = snapshot.image;
                  
                  coordinatePoint.x += pin.centerOffset.x - (CGRectGetWidth(pin.bounds) / 2.0);
                  coordinatePoint.y += pin.centerOffset.y - (CGRectGetHeight(pin.bounds) / 2.0);
                  
                  UIGraphicsBeginImageContextWithOptions(image.size, YES, image.scale);
                  {
                      [image drawAtPoint:CGPointZero];
                      [pin.image drawAtPoint:coordinatePoint];
                      self.cachedMapSnapshotImage = UIGraphicsGetImageFromCurrentImageContext();
                  }
                  UIGraphicsEndImageContext();
                  
                  if (completion) {
                      dispatch_async(dispatch_get_main_queue(), completion);
                  }
              }];
}

#pragma mark - MKAnnotation

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

#pragma mark - JSQMessageMediaData protocol

- (CGSize)mediaViewDisplaySizeWithMessageData:(id<JSQMessageData>)messageData layout:(JSQMessagesCollectionViewFlowLayout *)layout{
    self.viewSize = [super mediaViewDisplaySizeWithMessageData:messageData layout:layout];
    
    return self.viewSize;
}

- (UIView *)mediaViewWithMessageData:(id<JSQMessageData>)messageData layout:(JSQMessagesCollectionViewFlowLayout *)layout
{
    if (self.location == nil || self.cachedMapSnapshotImage == nil) {
        return nil;
    }
    
    if (self.cachedMediaView == nil) {
        CGSize size = [self mediaViewDisplaySizeWithMessageData:messageData layout:layout];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.cachedMapSnapshotImage];
        imageView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [JSQMessagesMediaViewBubbleImageMasker applyBubbleImageMaskToMediaView:imageView isOutgoing:self.appliesMediaViewMaskAsOutgoing];
        self.cachedMediaView = imageView;
    }
    
    return self.cachedMediaView;
}

- (NSUInteger)mediaHash
{
    return self.hash;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (![super isEqual:object]) {
        return NO;
    }
    
    JSQLocationMediaItem *locationItem = (JSQLocationMediaItem *)object;
    
    
    return [self.location distanceFromLocation:locationItem.location] == 0;
}

- (NSUInteger)hash
{
    return super.hash ^ [NSNumber numberWithFloat:self.location.coordinate.latitude].hash ^ [NSNumber numberWithFloat:self.location.coordinate.longitude].hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: location=%@, appliesMediaViewMaskAsOutgoing=%@>",
            [self class], self.location, @(self.appliesMediaViewMaskAsOutgoing)];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        CLLocation *location = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(location))];
        [self setLocation:location withCompletionHandler:nil];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.location forKey:NSStringFromSelector(@selector(location))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    JSQLocationMediaItem *copy = [[[self class] allocWithZone:zone] initWithLocation:self.location];
    copy.appliesMediaViewMaskAsOutgoing = self.appliesMediaViewMaskAsOutgoing;
    return copy;
}

@end
