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

#import "JSQMessagesAvatarImageFactory.h"

#import "UIColor+JSQMessages.h"


@interface JSQMessagesAvatarImageFactory ()

+ (UIImage *)jsq_circularImage:(UIImage *)image withDiamter:(NSUInteger)diameter;

+ (UIImage *)jsq_imageWitInitials:(NSString *)initials
                  backgroundColor:(UIColor *)backgroundColor
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font
                         diameter:(NSUInteger)diameter;

@end



@implementation JSQMessagesAvatarImageFactory

#pragma mark - Public

+ (JSQMessagesAvatarImage *)avatarImageWithPlaceholder:(UIImage *)placeholderImage diameter:(NSUInteger)diameter
{
    UIImage *circlePlaceholderImage = [JSQMessagesAvatarImageFactory jsq_circularImage:placeholderImage withDiamter:diameter];
    
    return [JSQMessagesAvatarImage avatarImageWithPlaceholder:circlePlaceholderImage];
}

+ (UIImage *)circularAvatarImage:(UIImage *)image withDiameter:(NSUInteger)diameter
{
    return [JSQMessagesAvatarImageFactory jsq_circularImage:image withDiamter:diameter];
}

+ (UIImage *)circularAvatarHighlightedImage:(UIImage *)image withDiameter:(NSUInteger)diameter
{
    // TODO: highlighted avatar image
    return [JSQMessagesAvatarImageFactory jsq_circularImage:image withDiamter:diameter];
}

+ (JSQMessagesAvatarImage *)avatarImageWithUserInitials:(NSString *)userInitials
                                        backgroundColor:(UIColor *)backgroundColor
                                              textColor:(UIColor *)textColor
                                                   font:(UIFont *)font
                                               diameter:(NSUInteger)diameter
{
    UIImage *avatarImage = [JSQMessagesAvatarImageFactory jsq_imageWitInitials:userInitials
                                                               backgroundColor:backgroundColor
                                                                     textColor:textColor
                                                                          font:font
                                                                      diameter:diameter];
    
    UIImage *avatarHighlightedImage = [JSQMessagesAvatarImageFactory jsq_imageWitInitials:userInitials
                                                                          backgroundColor:[backgroundColor jsq_colorByDarkeningColorWithValue:0.1f]
                                                                                textColor:[textColor jsq_colorByDarkeningColorWithValue:0.1f]
                                                                                     font:font
                                                                                 diameter:diameter];
    
    return [[JSQMessagesAvatarImage alloc] initWithAvatarImage:avatarImage
                                              highlightedImage:avatarHighlightedImage
                                              placeholderImage:avatarImage];
}

#pragma mark - Private

+ (UIImage *)jsq_imageWitInitials:(NSString *)initials
                  backgroundColor:(UIColor *)backgroundColor
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font
                         diameter:(NSUInteger)diameter
{
    NSParameterAssert(initials != nil);
    NSParameterAssert(backgroundColor != nil);
    NSParameterAssert(textColor != nil);
    NSParameterAssert(font != nil);
    NSParameterAssert(diameter > 0);
    
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    
    NSString *text = [initials uppercaseStringWithLocale:[NSLocale currentLocale]];
    
    NSDictionary *attributes = @{ NSFontAttributeName : font,
                                  NSForegroundColorAttributeName : textColor };
    
    CGRect textFrame = [text boundingRectWithSize:frame.size
                                          options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       attributes:attributes
                                          context:nil];
    
    CGPoint frameMidPoint = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGPoint textFrameMidPoint = CGPointMake(CGRectGetMidX(textFrame), CGRectGetMidY(textFrame));
    
    CGFloat dx = frameMidPoint.x - textFrameMidPoint.x;
    CGFloat dy = frameMidPoint.y - textFrameMidPoint.y;
    CGPoint drawPoint = CGPointMake(dx, dy);
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
    CGContextFillRect(context, frame);
    [text drawAtPoint:drawPoint withAttributes:attributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return [JSQMessagesAvatarImageFactory jsq_circularImage:image withDiamter:diameter];
}

+ (UIImage *)jsq_circularImage:(UIImage *)image withDiamter:(NSUInteger)diameter
{
    NSParameterAssert(image != nil);
    NSParameterAssert(diameter > 0);
    
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:frame];
    [imgPath addClip];
    [image drawInRect:frame];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return newImage;
}

@end
