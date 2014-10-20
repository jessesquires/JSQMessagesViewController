//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>

#import "JSQMessagesBubbleImageFactory.h"

#import "UIImage+JSQMessages.h"


@interface JSQMessagesBubbleImageFactoryTests : XCTestCase

@property (strong, nonatomic) JSQMessagesBubbleImageFactory *factory;

@end


@implementation JSQMessagesBubbleImageFactoryTests

- (void)setUp
{
    [super setUp];
    self.factory = [[JSQMessagesBubbleImageFactory alloc] init];
}

- (void)tearDown
{
    self.factory = nil;
    [super tearDown];
}

- (void)testOutgoingMessageBubbleImageView
{
    UIImage *bubble = [UIImage jsq_bubbleCompactImage];
    XCTAssertNotNil(bubble, @"Bubble image should not be nil");
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, bubble.size.height / 2.0f);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
    
    JSQMessagesBubbleImage *bubbleImage = [self.factory outgoingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
    XCTAssertNotNil(bubbleImage, @"Bubble image should not be nil");
    
    XCTAssertNotNil(bubbleImage.messageBubbleImage, "Image should not be nil");
    XCTAssertEqual(bubbleImage.messageBubbleImage.scale, bubble.scale, @"Image scale should equal bubble image scale");
    XCTAssertEqual(bubbleImage.messageBubbleImage.imageOrientation, bubble.imageOrientation, @"Image orientation should equal bubble image orientation");
    XCTAssertTrue(bubbleImage.messageBubbleImage.resizingMode == UIImageResizingModeStretch, @"Image should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(bubbleImage.messageBubbleImage.capInsets, capInsets), @"Image capInsets should be equal to capInsets");
    
    
    XCTAssertNotNil(bubbleImage.messageBubbleHighlightedImage, @"Highlighted image should not be nil");
    XCTAssertEqual(bubbleImage.messageBubbleHighlightedImage.scale, bubble.scale, @"HighlightedImage scale should equal bubble image scale");
    XCTAssertEqual(bubbleImage.messageBubbleHighlightedImage.imageOrientation, bubble.imageOrientation, @"HighlightedImage orientation should equal bubble image orientation");
    XCTAssertTrue(bubbleImage.messageBubbleHighlightedImage.resizingMode == UIImageResizingModeStretch, @"HighlightedImage should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(bubbleImage.messageBubbleHighlightedImage.capInsets, capInsets), @"HighlightedImage capInsets should be equal to capInsets");
}

- (void)testIncomingMessageBubbleImageView
{
    UIImage *bubble = [UIImage jsq_bubbleCompactImage];
    XCTAssertNotNil(bubble, @"Bubble image should not be nil");
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, bubble.size.height / 2.0f);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
    
    JSQMessagesBubbleImage *bubbleImage = [self.factory incomingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
    XCTAssertNotNil(bubbleImage, @"Bubble image should not be nil");
    
    XCTAssertNotNil(bubbleImage.messageBubbleImage, "Image should not be nil");
    XCTAssertEqual(bubbleImage.messageBubbleImage.scale, bubble.scale, @"Image scale should equal bubble image scale");
    XCTAssertEqual(bubbleImage.messageBubbleImage.imageOrientation, UIImageOrientationUpMirrored, @"Image orientation should be flipped");
    XCTAssertTrue(bubbleImage.messageBubbleImage.resizingMode == UIImageResizingModeStretch, @"Image should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(bubbleImage.messageBubbleImage.capInsets, capInsets), @"Image capInsets should be equal to capInsets");
    
    
    XCTAssertNotNil(bubbleImage.messageBubbleHighlightedImage, @"Highlighted image should not be nil");
    XCTAssertEqual(bubbleImage.messageBubbleHighlightedImage.scale, bubble.scale, @"HighlightedImage scale should equal bubble image scale");
    XCTAssertEqual(bubbleImage.messageBubbleHighlightedImage.imageOrientation, UIImageOrientationUpMirrored, @"Image orientation should be flipped");
    XCTAssertTrue(bubbleImage.messageBubbleHighlightedImage.resizingMode == UIImageResizingModeStretch, @"HighlightedImage should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(bubbleImage.messageBubbleHighlightedImage.capInsets, capInsets), @"HighlightedImage capInsets should be equal to capInsets");
}

- (void)testCustomOutgoingMessageBubbleImageView
{
    UIImage *bubble = [UIImage jsq_bubbleRegularStrokedTaillessImage];
    XCTAssertNotNil(bubble, @"Bubble image should not be nil");
    
    UIEdgeInsets capInsets = UIEdgeInsetsMake(1, 1, 1, 1);
    JSQMessagesBubbleImageFactory *factory = [[JSQMessagesBubbleImageFactory alloc] initWithBubbleImage:bubble capInsets:capInsets];
    JSQMessagesBubbleImage *bubbleImage = [factory outgoingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
    XCTAssertNotNil(bubbleImage, @"Bubble image should not be nil");
    
    XCTAssertNotNil(bubbleImage.messageBubbleImage, "Image should not be nil");
    XCTAssertEqual(bubbleImage.messageBubbleImage.scale, bubble.scale, @"Image scale should equal bubble image scale");
    XCTAssertEqual(bubbleImage.messageBubbleImage.imageOrientation, bubble.imageOrientation, @"Image orientation should equal bubble image orientation");
    XCTAssertTrue(bubbleImage.messageBubbleImage.resizingMode == UIImageResizingModeStretch, @"Image should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(bubbleImage.messageBubbleImage.capInsets, capInsets), @"Image capInsets should be equal to capInsets");
    
    XCTAssertNotNil(bubbleImage.messageBubbleHighlightedImage, @"Highlighted image should not be nil");
    XCTAssertEqual(bubbleImage.messageBubbleHighlightedImage.scale, bubble.scale, @"HighlightedImage scale should equal bubble image scale");
    XCTAssertEqual(bubbleImage.messageBubbleHighlightedImage.imageOrientation, bubble.imageOrientation, @"HighlightedImage orientation should equal bubble image orientation");
    XCTAssertTrue(bubbleImage.messageBubbleHighlightedImage.resizingMode == UIImageResizingModeStretch, @"HighlightedImage should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(bubbleImage.messageBubbleHighlightedImage.capInsets, capInsets), @"HighlightedImage capInsets should be equal to capInsets");
}

- (void)testCustomIncomingMessageBubbleImageView
{
    UIImage *bubble = [UIImage jsq_bubbleRegularStrokedTaillessImage];
    XCTAssertNotNil(bubble, @"Bubble image should not be nil");
    
    UIEdgeInsets capInsets = UIEdgeInsetsMake(1, 1, 1, 1);
    JSQMessagesBubbleImageFactory *factory = [[JSQMessagesBubbleImageFactory alloc] initWithBubbleImage:bubble capInsets:capInsets];
    JSQMessagesBubbleImage *bubbleImage = [factory incomingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
    XCTAssertNotNil(bubbleImage, @"Bubble image should not be nil");
    
    XCTAssertNotNil(bubbleImage.messageBubbleImage, "Image should not be nil");
    XCTAssertEqual(bubbleImage.messageBubbleImage.scale, bubble.scale, @"Image scale should equal bubble image scale");
    XCTAssertEqual(bubbleImage.messageBubbleImage.imageOrientation, UIImageOrientationUpMirrored, @"Image orientation should be flipped");
    XCTAssertTrue(bubbleImage.messageBubbleImage.resizingMode == UIImageResizingModeStretch, @"Image should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(bubbleImage.messageBubbleImage.capInsets, capInsets), @"Image capInsets should be equal to capInsets");
    
    XCTAssertNotNil(bubbleImage.messageBubbleHighlightedImage, @"Highlighted image should not be nil");
    XCTAssertEqual(bubbleImage.messageBubbleHighlightedImage.scale, bubble.scale, @"HighlightedImage scale should equal bubble image scale");
    XCTAssertEqual(bubbleImage.messageBubbleHighlightedImage.imageOrientation, UIImageOrientationUpMirrored, @"Image orientation should be flipped");
    XCTAssertTrue(bubbleImage.messageBubbleHighlightedImage.resizingMode == UIImageResizingModeStretch, @"HighlightedImage should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(bubbleImage.messageBubbleHighlightedImage.capInsets, capInsets), @"HighlightedImage capInsets should be equal to capInsets");
}

@end
