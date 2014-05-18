//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

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
    
    
    UIImageView *imageView = [JSQMessagesBubbleImageFactory outgoingMessageBubbleImageViewWithColor:[UIColor lightGrayColor]];
    XCTAssertNotNil(imageView, @"ImageView should not be nil");
    XCTAssertEqualObjects(imageView.backgroundColor, [UIColor whiteColor], @"ImageView should have white background color");
    XCTAssertTrue(CGSizeEqualToSize(imageView.frame.size, bubble.size), @"ImageView size should equal bubble size");
    
    
    XCTAssertNotNil(imageView.image, @"Image should not be nil");
    XCTAssertEqual(imageView.image.scale, bubble.scale, @"Image scale should equal bubble image scale");
    XCTAssertEqual(imageView.image.imageOrientation, bubble.imageOrientation, @"Image orientation should equal bubble image orientation");
    XCTAssertTrue(imageView.image.resizingMode == UIImageResizingModeStretch, @"Image should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(imageView.image.capInsets, capInsets), @"Image capInsets should be equal to capInsets");
    
    
    XCTAssertNotNil(imageView.highlightedImage, @"HighlightedImage should not be nil");
    XCTAssertEqual(imageView.highlightedImage.scale, bubble.scale, @"HighlightedImage scale should equal bubble image scale");
    XCTAssertEqual(imageView.highlightedImage.imageOrientation, bubble.imageOrientation, @"HighlightedImage orientation should equal bubble image orientation");
    XCTAssertTrue(imageView.highlightedImage.resizingMode == UIImageResizingModeStretch, @"HighlightedImage should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(imageView.highlightedImage.capInsets, capInsets), @"HighlightedImage capInsets should be equal to capInsets");
}

- (void)testIncomingMessageBubbleImageView
{
    UIImage *bubble = [UIImage imageNamed:@"bubble_min"];
    XCTAssertNotNil(bubble, @"Bubble image should not be nil");
    
    CGPoint center = CGPointMake(bubble.size.width / 2.0f, bubble.size.height / 2.0f);
    UIEdgeInsets capInsets = UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
    
    
    UIImageView *imageView = [JSQMessagesBubbleImageFactory incomingMessageBubbleImageViewWithColor:[UIColor lightGrayColor]];
    XCTAssertNotNil(imageView, @"ImageView should not be nil");
    XCTAssertEqualObjects(imageView.backgroundColor, [UIColor whiteColor], @"ImageView should have white background color");
    XCTAssertTrue(CGSizeEqualToSize(imageView.frame.size, bubble.size), @"ImageView size should equal bubble size");
    
    
    XCTAssertNotNil(imageView.image, @"Image should not be nil");
    XCTAssertEqual(imageView.image.scale, bubble.scale, @"Image scale should equal bubble image scale");
    XCTAssertEqual(imageView.image.imageOrientation, UIImageOrientationUpMirrored, @"Image orientation should be flipped");
    XCTAssertTrue(imageView.image.resizingMode == UIImageResizingModeStretch, @"Image should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(imageView.image.capInsets, capInsets), @"Image capInsets should be equal to capInsets");
    
    
    XCTAssertNotNil(imageView.highlightedImage, @"HighlightedImage should not be nil");
    XCTAssertEqual(imageView.highlightedImage.scale, bubble.scale, @"HighlightedImage scale should equal bubble image scale");
    XCTAssertEqual(imageView.highlightedImage.imageOrientation, UIImageOrientationUpMirrored, @"HighlightedImage orientation should be flipped");
    XCTAssertTrue(imageView.highlightedImage.resizingMode == UIImageResizingModeStretch, @"HighlightedImage should be stretchable");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(imageView.highlightedImage.capInsets, capInsets), @"HighlightedImage capInsets should be equal to capInsets");
}

@end
