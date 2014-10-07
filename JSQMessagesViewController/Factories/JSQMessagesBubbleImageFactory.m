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

@property (nonatomic, readwrite, strong) UIImage *bubbleImage;
@property (nonatomic, readwrite, assign) UIEdgeInsets capInsets;

- (JSQMessagesBubbleImage *)messagesBubbleImageWithColor:(UIColor *)color flippedForIncoming:(BOOL)flippedForIncoming;

+ (UIImage *)jsq_horizontallyFlippedImageFromImage:(UIImage *)image;

+ (UIImage *)jsq_stretchableImageFromImage:(UIImage *)image withCapInsets:(UIEdgeInsets)capInsets;

@end



@implementation JSQMessagesBubbleImageFactory

@synthesize bubbleImage;
@synthesize capInsets;


#pragma mark - Public

- (instancetype)initWithBubbleImage:(UIImage *)image capInsets:(UIEdgeInsets)insets {
	NSParameterAssert(image != nil);
	self = [super init];
	if (self) {
		self.bubbleImage = image;
		self.capInsets = insets;
	}
	return self;
}

- (instancetype)init {
	UIImage *bubble = [UIImage imageNamed:@"bubble_min"];
	NSAssert(bubble != nil, @"Unable to load default image in %s. Please make sure default resources are included in your project.",
			 __PRETTY_FUNCTION__);
	CGPoint center = CGPointMake(bubble.size.width / 2.0f, bubble.size.height / 2.0f);
	UIEdgeInsets insets = UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
	return [self initWithBubbleImage:bubble capInsets:insets];
}

- (JSQMessagesBubbleImage *)outgoingMessagesBubbleImageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    return [self messagesBubbleImageWithColor:color flippedForIncoming:NO];
}

- (JSQMessagesBubbleImage *)incomingMessagesBubbleImageWithColor:(UIColor *)color
{
    NSParameterAssert(color != nil);
    return [self messagesBubbleImageWithColor:color flippedForIncoming:YES];
}

#pragma mark - Private

- (JSQMessagesBubbleImage *)messagesBubbleImageWithColor:(UIColor *)color flippedForIncoming:(BOOL)flippedForIncoming
{
    UIImage *normalBubble = [self.bubbleImage jsq_imageMaskedWithColor:color];
    UIImage *highlightedBubble = [self.bubbleImage jsq_imageMaskedWithColor:[color jsq_colorByDarkeningColorWithValue:0.12f]];
    
    if (flippedForIncoming) {
        normalBubble = [JSQMessagesBubbleImageFactory jsq_horizontallyFlippedImageFromImage:normalBubble];
        highlightedBubble = [JSQMessagesBubbleImageFactory jsq_horizontallyFlippedImageFromImage:highlightedBubble];
    }
    
    normalBubble = [JSQMessagesBubbleImageFactory jsq_stretchableImageFromImage:normalBubble withCapInsets:self.capInsets];
    highlightedBubble = [JSQMessagesBubbleImageFactory jsq_stretchableImageFromImage:highlightedBubble withCapInsets:self.capInsets];
    
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
