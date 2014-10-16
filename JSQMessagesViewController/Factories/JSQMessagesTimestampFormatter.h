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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  An instance of `JSQMessagesTimestampFormatter` is a singleton object that provides an efficient means 
 *  for creating attributed and non-attributed string representations of `NSDate` objects. 
 *  It is intended to be used as the method by which you display timestamps in a `JSQMessagesCollectionView`.
 */
@interface JSQMessagesTimestampFormatter : NSObject

/**
 *  Returns the cached date formatter object used by the `JSQMessagesTimestampFormatter` shared instance.
 */
@property (strong, nonatomic, readonly) NSDateFormatter *dateFormatter;

/**
 *  The text attributes to apply to the day, month, and year components of the string representation of a given date. 
 *  The default value is a dictionary containing attributes that specify centered, light gray text and the bold system font at size `12.0f`.
 */
@property (copy, nonatomic) NSDictionary *dateTextAttributes;

/**
 *  The text attributes to apply to the minute and hour componenents of the string representation of a given date. 
 *  The default value is a dictionary containing attributes that specify centered, light gray text and the system font at size `12.0f`.
 */
@property (copy, nonatomic) NSDictionary *timeTextAttributes;

/**
 *  Returns the shared timestamp formatter object.
 *
 *  @return The shared timestamp formatter object.
 */
+ (JSQMessagesTimestampFormatter *)sharedFormatter;

/**
 *  Returns a string representation of the given date formatted in the current locale using `NSDateFormatterMediumStyle` for the date style 
 *  and `NSDateFormatterShortStyle` for the time style. It uses relative date formatting where possible.
 *
 *  @param date The date to format.
 *
 *  @return A formatted string representation of date.
 */
- (NSString *)timestampForDate:(NSDate *)date;

/**
 *  Returns an attributed string representation of the given date formatted as described in `timestampForDate:`. 
 *  It applies the attributes in `dateTextAttributes` and `timeTextAttributes`, respectively.
 *
 *  @param date The date to format.
 *
 *  @return A formatted, attributed string representation of date.
 *
 *  @see `timestampForDate:`.
 *  @see `dateTextAttributes`.
 *  @see `timeTextAttributes`.
 */
- (NSAttributedString *)attributedTimestampForDate:(NSDate *)date;

/**
 *  Returns a string representation of *only* the minute and hour components of the given date formatted in the current locale styled using `NSDateFormatterShortStyle`.
 *
 *  @param date The date to format.
 *
 *  @return A formatted string representation of the minute and hour components of date.
 */
- (NSString *)timeForDate:(NSDate *)date;

/**
 *  Returns a string representation of *only* the day, month, and year components of the given date formatted in the current locale styled using `NSDateFormatterMediumStyle`.
 *
 *  @param date The date to format.
 *
 *  @return A formatted string representation of the day, month, and year components of date.
 */
- (NSString *)relativeDateForDate:(NSDate *)date;

@end
