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


@interface JSQLocationMediaItem ()

@property (strong, nonatomic) MKMapView *cachedMapView;

@end


@implementation JSQLocationMediaItem

#pragma mark - Initialization

- (instancetype)initWithLocation:(CLLocation *)location
{
    self = [super init];
    if (self) {
        _location = [location copy];
        _cachedMapView = nil;
    }
    return self;
}

- (void)dealloc
{
    _location = nil;
    _cachedMapView = nil;
}

#pragma mark - Setters

- (void)setLocation:(CLLocation *)location
{
    _location = [location copy];
    _cachedMapView = nil;
}

#pragma mark - MKAnnotation

- (CLLocationCoordinate2D)coordinate
{
    return self.location.coordinate;
}

#pragma mark - JSQMessageMediaData protocol

- (UIView *)mediaView
{
    if (self.location == nil) {
        return nil;
    }
    
    if (self.cachedMapView == nil) {
        CGSize size = [self mediaViewDisplaySize];
        MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        mapView.centerCoordinate = self.location.coordinate;
        mapView.layer.cornerRadius = 20.0f;
        mapView.clipsToBounds = YES;
        mapView.showsUserLocation = NO;
        mapView.userInteractionEnabled = NO;
        [mapView addAnnotation:self];
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.location.coordinate, 10, 10);
        [mapView setRegion:[mapView regionThatFits:region] animated:NO];
        self.cachedMapView = mapView;
    }
    
    return self.cachedMapView;
}

- (CGSize)mediaViewDisplaySize
{
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return CGSizeMake(315.0f, 225.0f);
    }
    return CGSizeMake(210.0f, 150.0f);
}

- (UIView *)mediaPlaceholderView
{
    return [JSQMessagesMediaPlaceholderView viewWithActivityIndicator];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    JSQLocationMediaItem *locationItem = (JSQLocationMediaItem *)object;
    
    return [self.location isEqual:locationItem.location];
}

- (NSUInteger)hash
{
    return self.location.hash;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: location=%@>", [self class], self.location];
}

- (id)debugQuickLookObject
{
    return [self mediaView] ?: [self mediaPlaceholderView];
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _location = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(location))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.location forKey:NSStringFromSelector(@selector(location))];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithLocation:self.location];
}

@end
