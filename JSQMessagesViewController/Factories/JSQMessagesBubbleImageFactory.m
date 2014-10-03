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

#import "JSQMessagesBubbleImageFactory.h"

#import "UIImage+JSQMessages.h"
#import "UIColor+JSQMessages.h"


@interface JSQMessagesBubbleImageFactory ()

+ (JSQMessagesBubbleImage *)messagesBubbleImageWithColor:(UIColor *)color flippedForIncoming:(BOOL)flippedForIncoming;

+ (UIImage *)jsq_horizontallyFlippedImageFromImage:(UIImage *)image;

+ (UIImage *)jsq_stretchableImageFromImage:(UIImage *)image withCapInsets:(UIEdgeInsets)capInsets;

@end



@implementation JSQMessagesBubbleImageFactory

#pragma mark - Public

+ (JSQMessagesBubbleImage *)outgoingMessagesBubbleImageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    return [JSQMessagesBubbleImageFactory messagesBubbleImageWithColor:color flippedForIncoming:NO];
}

+ (JSQMessagesBubbleImage *)incomingMessagesBubbleImageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    return [JSQMessagesBubbleImageFactory messagesBubbleImageWithColor:color flippedForIncoming:YES];
}

#pragma mark - Private

+ (JSQMessagesBubbleImage *)messagesBubbleImageWithColor:(UIColor *)color flippedForIncoming:(BOOL)flippedForIncoming
{
    UIImage *bubble = [UIImage imageNamed:@"bubble_min"];
    
    UIImage *normalBubble = [bubble jsq_imageMaskedWithColor:color];
    UIImage *highlightedBubble = [bubble jsq_imageMaskedWithColor:[color jsq_colorByDarkeningColorWithValue:0.12f]];
    
    if (flippedForIncoming) {
        normalBubble = [JSQMessagesBubbleImageFactory jsq_horizontallyFlippedImageFromImage:normalBubble];
        highlightedBubble = [JSQMessagesBubbleImageFactory jsq_horizontallyFlippedImageFromImage:highlightedBubble];
    }
    
    // make image stretchable from center point
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, bubble.size.height / 2.0f);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
    
    normalBubble = [JSQMessagesBubbleImageFactory jsq_stretchableImageFromImage:normalBubble withCapInsets:capInsets];
    highlightedBubble = [JSQMessagesBubbleImageFactory jsq_stretchableImageFromImage:highlightedBubble withCapInsets:capInsets];
    
    return [[JSQMessagesBubbleImage alloc] initWithMessageBubbleImage:normalBubble highlightedImage:highlightedBubble];
}

+ (UIImage *)jsq_horizontallyFlippedImageFromImage:(UIImage *)image
{
    return [UIImage imageWithCGImage:image.CGImage
                               scale:image.scale
                         orientation:UIImageOrientationUpMirrored];
}

+ (UIImage *)jsq_stretchableImageFromImage:(UIImage *)image withCapInsets:(UIEdgeInsets)capInsets
{
    return [image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}

@end
