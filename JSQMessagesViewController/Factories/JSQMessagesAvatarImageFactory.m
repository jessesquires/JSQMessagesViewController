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

#import "JSQMessagesAvatarImageFactory.h"

#import "UIColor+JSQMessages.h"

// TODO: define kJSQMessagesCollectionViewAvatarSizeDefault elsewhere so we can remove this import
#import "JSQMessagesCollectionViewFlowLayout.h"

@interface JSQMessagesAvatarImageFactory ()

@property (assign, nonatomic, readonly) NSUInteger diameter;

@end

@implementation JSQMessagesAvatarImageFactory

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithDiameter:kJSQMessagesCollectionViewAvatarSizeDefault];
}

- (instancetype)initWithDiameter:(NSUInteger)diameter
{
    NSParameterAssert(diameter > 0);
    
    self = [super init];
    if (self) {
        _diameter = diameter;
    }
    
    return self;
}

#pragma mark - Public

- (JSQMessagesAvatarImage *)avatarImageWithPlaceholder:(UIImage *)placeholderImage
{
    UIImage *circlePlaceholderImage = [self jsq_circularImage:placeholderImage
                                         withHighlightedColor:nil];

    return [JSQMessagesAvatarImage avatarImageWithPlaceholder:circlePlaceholderImage];
}

- (JSQMessagesAvatarImage *)avatarImageWithImage:(UIImage *)image
{
    UIImage *avatar = [self circularAvatarImage:image];
    UIImage *highlightedAvatar = [self circularAvatarHighlightedImage:image];

    return [[JSQMessagesAvatarImage alloc] initWithAvatarImage:avatar
                                              highlightedImage:highlightedAvatar
                                              placeholderImage:avatar];
}

- (UIImage *)circularAvatarImage:(UIImage *)image
{
    return [self jsq_circularImage:image
              withHighlightedColor:nil];
}

- (UIImage *)circularAvatarHighlightedImage:(UIImage *)image
{
    return [self jsq_circularImage:image
              withHighlightedColor:[UIColor colorWithWhite:0.1f alpha:0.3f]];
}

- (JSQMessagesAvatarImage *)avatarImageWithUserInitials:(NSString *)userInitials
                                        backgroundColor:(UIColor *)backgroundColor
                                              textColor:(UIColor *)textColor
                                                   font:(UIFont *)font
{
    UIImage *avatarImage = [self jsq_imageWithInitials:userInitials
                                       backgroundColor:backgroundColor
                                             textColor:textColor
                                                  font:font];

    UIImage *avatarHighlightedImage = [self jsq_circularImage:avatarImage
                                         withHighlightedColor:[UIColor colorWithWhite:0.1f alpha:0.3f]];

    return [[JSQMessagesAvatarImage alloc] initWithAvatarImage:avatarImage
                                              highlightedImage:avatarHighlightedImage
                                              placeholderImage:avatarImage];
}

#pragma mark - Private

- (UIImage *)jsq_imageWithInitials:(NSString *)initials
                   backgroundColor:(UIColor *)backgroundColor
                         textColor:(UIColor *)textColor
                              font:(UIFont *)font
{
    NSParameterAssert(initials != nil);
    NSParameterAssert(backgroundColor != nil);
    NSParameterAssert(textColor != nil);
    NSParameterAssert(font != nil);

    CGRect frame = CGRectMake(0.0f, 0.0f, self.diameter, self.diameter);

    NSDictionary *attributes = @{ NSFontAttributeName : font,
                                  NSForegroundColorAttributeName : textColor };

    CGRect textFrame = [initials boundingRectWithSize:frame.size
                                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes:attributes
                                              context:nil];

    CGPoint frameMidPoint = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGPoint textFrameMidPoint = CGPointMake(CGRectGetMidX(textFrame), CGRectGetMidY(textFrame));

    CGFloat dx = frameMidPoint.x - textFrameMidPoint.x;
    CGFloat dy = frameMidPoint.y - textFrameMidPoint.y;
    CGPoint drawPoint = CGPointMake(dx, dy);
    UIImage *image = nil;

    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();

        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, frame);
        [initials drawAtPoint:drawPoint withAttributes:attributes];

        image = UIGraphicsGetImageFromCurrentImageContext();

    }
    UIGraphicsEndImageContext();

    return [self jsq_circularImage:image withHighlightedColor:nil];
}

- (UIImage *)jsq_circularImage:(UIImage *)image withHighlightedColor:(UIColor *)highlightedColor
{
    NSParameterAssert(image != nil);

    CGRect frame = CGRectMake(0.0f, 0.0f, self.diameter, self.diameter);
    UIImage *newImage = nil;

    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();

        UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:frame];
        [imgPath addClip];
        [image drawInRect:frame];

        if (highlightedColor != nil) {
            CGContextSetFillColorWithColor(context, highlightedColor.CGColor);
            CGContextFillEllipseInRect(context, frame);
        }

        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
