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

#import "JSQMessagesBubbleImage.h"

#import "UIImage+JSQMessages.h"


@interface JSQMessagesBubbleImageTests : XCTestCase

@end


@implementation JSQMessagesBubbleImageTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInitInvalid
{
    XCTAssertThrows([[JSQMessagesBubbleImage alloc] initWithMessageBubbleImage:nil highlightedImage:nil], @"Invalid init should throw");
}

- (void)testInitValid
{
    UIImage *mockImage = [UIImage jsq_bubbleCompactImage];
    JSQMessagesBubbleImage *bubbleImage = [[JSQMessagesBubbleImage alloc] initWithMessageBubbleImage:mockImage highlightedImage:mockImage];
    XCTAssertNotNil(bubbleImage, @"Valid init should succeed");
}

- (void)testCopy
{
    UIImage *mockImage = [UIImage jsq_bubbleCompactImage];
    JSQMessagesBubbleImage *bubbleImage = [[JSQMessagesBubbleImage alloc] initWithMessageBubbleImage:mockImage highlightedImage:mockImage];
    
    JSQMessagesBubbleImage *copy = [bubbleImage copy];
    XCTAssertNotNil(copy, @"Copy should succeed");
    
    XCTAssertFalse(bubbleImage == copy, @"Copy should return new, distinct instance");
    
    XCTAssertNotEqualObjects(bubbleImage.messageBubbleImage, copy.messageBubbleImage, @"Images should not be equal");
    XCTAssertNotEqual(bubbleImage.messageBubbleImage, copy.messageBubbleImage, @"Images should not be equal");
    
    XCTAssertNotEqualObjects(bubbleImage.messageBubbleHighlightedImage, copy.messageBubbleHighlightedImage, @"Images should not be equal");
    XCTAssertNotEqual(bubbleImage.messageBubbleHighlightedImage, copy.messageBubbleHighlightedImage, @"Images should not be equal");
}

@end
