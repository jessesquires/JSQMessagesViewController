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

#import "JSQAvatarFactory.h"

@interface JSQAvatarFactory ()

+ (UIImage *)jsq_circularImage:(UIImage *)image withDiamter:(NSUInteger)diameter;

@end



@implementation JSQAvatarFactory

#pragma mark - Public

+ (UIImage *)avatarWithImage:(UIImage *)originalImage diameter:(NSUInteger)diameter
{
    return [JSQAvatarFactory jsq_circularImage:originalImage withDiamter:diameter];
}

#pragma mark - Private

+ (UIImage *)jsq_circularImage:(UIImage *)image withDiamter:(NSUInteger)diameter
{
    CGRect frame = CGRectMake(0.0f, 0.0f, diameter, diameter);
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, image.scale);
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
