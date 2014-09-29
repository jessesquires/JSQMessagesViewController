//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

@import XCTest;

#import "JSQMessagesBubbleImageFactory.h"


@interface JSQMessagesBubbleImageFactoryTests : XCTestCase
@end


@implementation JSQMessagesBubbleImageFactoryTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testOutgoingMessageBubbleImageView
{
    UIImage *bubble = [UIImage imageNamed:@"bubble_min"];
    XCTAssertNotNil(bubble, @"Bubble image should not be nil");
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, bubble.size.height / 2.0f);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
    
    
    JSQMessagesBubbleImage *bubbleImage = [JSQMessagesBubbleImageFactory outgoingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
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
    UIImage *bubble = [UIImage imageNamed:@"bubble_min"];
    XCTAssertNotNil(bubble, @"Bubble image should not be nil");
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, bubble.size.height / 2.0f);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
    
    
    JSQMessagesBubbleImage *bubbleImage = [JSQMessagesBubbleImageFactory incomingMessagesBubbleImageWithColor:[UIColor lightGrayColor]];
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
