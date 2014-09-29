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

#ifndef JSQMessages_JSQMessageData_h
#define JSQMessages_JSQMessageData_h

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, JSQMessageType) {
	JSQMessageTypeText,
	JSQMessageTypeImage
};

/**
 *  The `JSQMessageData` protocol defines the common interface through 
 *  which `JSQMessagesViewController` and `JSQMessagesCollectionView` interacts with message model objects.
 *
 *  It declares the required and optional methods that a class must implement so that instances of that class 
 *  can be displayed properly with a `JSQMessagesCollectionViewCell`.
 */
@protocol JSQMessageData <NSObject>

@required

/**
 *  @return The body type of the message.
 */
- (JSQMessageType)type;

/**
 *  @return The body text of the message.
 *  @warning You must not return `nil` from this method if type == JSQMessageTypeText
 */
- (NSString *)text;

/**
 *  @return The body image of the message.
 *  @warning You must not return `nil` from this method if type == JSQMessageTypeImage
 */
- (UIImage *)image;

/**
 *  @return The name of the user who sent the message.
 *  @warning You must not return `nil` from this method.
 */
- (NSString *)sender;

/**
 *  @return The date that the message was sent.
 *  @warning You must not return `nil` from this method.
 */
- (NSDate *)date;

@end

#endif