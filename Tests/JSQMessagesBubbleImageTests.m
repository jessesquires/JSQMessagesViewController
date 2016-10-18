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

#import <XCTest/XCTest.h>
#import <JSQMessagesViewController/JSQMessagesViewController.h>


@interface JSQMessagesBubbleImageTests : XCTestCase

@end


@implementation JSQMessagesBubbleImageTests

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
