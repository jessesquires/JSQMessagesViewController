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

@import CoreLocation;
@import MapKit;

#import "JSQMessageMediaData.h"

/**
 *  The `JSQLocationMediaItem` class is a concrete class that implements the `JSQMessageMediaData` protocol
 *  and represents a location media message. An initialized `JSQLocationMediaItem` object can be passed
 *  to a `JSQMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `JSQLocationMediaItem` to provide additional functionality or behavior.
 */
@interface JSQLocationMediaItem : NSObject <JSQMessageMediaData, MKAnnotation, NSCoding, NSCopying>

/**
 *  The location for the location media item. The default value is `nil`.
 */
@property (copy, nonatomic) CLLocation *location;

/**
 *  The coordinate of the location property.
 */
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;

/**
 *  Initializes and returns a location media item object having the given location.
 *
 *  @param location The location for the location media item. This value may be `nil`.
 *
 *  @return An initialized `JSQLocationMediaItem` if successful, `nil` otherwise.
 *
 *  @discussion If the location data must be dowloaded from the network,
 *  you may initialize a `JSQLocationMediaItem` object with a `nil` location.
 *  Once the location data has been retrieved, you can then set the location property.
 */
- (instancetype)initWithLocation:(CLLocation *)location;

@end
