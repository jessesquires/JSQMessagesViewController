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
//  Copyright (c) 2013 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import "UIImage+JSMessagesView.h"

@implementation UIImage (JSMessagesView)

- (UIImage *)js_imageFlippedHorizontal
{
    return [UIImage imageWithCGImage:self.CGImage
                               scale:self.scale
                         orientation:UIImageOrientationUpMirrored];
}

- (UIImage *)js_stretchableImageWithCapInsets:(UIEdgeInsets)capInsets
{
    return [self resizableImageWithCapInsets:capInsets
                                resizingMode:UIImageResizingModeStretch];
}

- (UIImage *)js_imageAsCircle:(BOOL)clipToCircle
                  withDiamter:(CGFloat)diameter
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                 shadowOffSet:(CGSize)shadowOffset
{
    // increase given size for border and shadow
    CGFloat increase = diameter * 0.1f;
    CGFloat newSize = diameter + increase;
    
    CGRect newRect = CGRectMake(0.0f,
                                0.0f,
                                newSize,
                                newSize);
    
    // fit image inside border and shadow
    CGRect imgRect = CGRectMake(increase,
                                increase,
                                newRect.size.width - (increase * 2.0f),
                                newRect.size.height - (increase * 2.0f));
    
    UIGraphicsBeginImageContextWithOptions(newRect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // draw shadow
    if(!CGSizeEqualToSize(shadowOffset, CGSizeZero)) {
        CGContextSetShadowWithColor(context,
                                    CGSizeMake(shadowOffset.width, shadowOffset.height),
                                    2.0f,
                                    [UIColor colorWithWhite:0.0f alpha:0.45f].CGColor);
    }
    
    // draw border
    if(borderColor && borderWidth) {
        CGPathRef borderPath = (clipToCircle) ? CGPathCreateWithEllipseInRect(imgRect, NULL) : CGPathCreateWithRect(imgRect, NULL);
        CGContextAddPath(context, borderPath);
        
        CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
        CGContextSetLineWidth(context, borderWidth);
        CGContextDrawPath(context, kCGPathFillStroke);
        
        CGPathRelease(borderPath);
    }
    
    CGContextRestoreGState(context);
    
    if(clipToCircle) {
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:imgRect];
        [imgPath addClip];
    }
    
    [self drawInRect:imgRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)js_imageMaskWithColor:(UIColor *)maskColor
{
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextScaleCTM(ctx, 1.0f, -1.0f);
    CGContextTranslateCTM(ctx, 0.0f, -(imageRect.size.height));
    
    CGContextClipToMask(ctx, imageRect, self.CGImage);
    CGContextSetFillColorWithColor(ctx, maskColor.CGColor);
    CGContextFillRect(ctx, imageRect);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
