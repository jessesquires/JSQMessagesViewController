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

#import "UIImage+JSQMessages.h"


@interface JSQMessagesUIImageTests : XCTestCase
@end


@implementation JSQMessagesUIImageTests

- (void)testImageMasking
{
    // GIVEN: an image
    UIImage *img = [UIImage jsq_bubbleCompactImage];
    XCTAssertNotNil(img, @"Image should not be nil");
    
    // WHEN: we mask that image
    UIImage *imgMasked = [img jsq_imageMaskedWithColor:[UIColor whiteColor]];
    XCTAssertNotNil(imgMasked, @"Image should not be nil");
    
    // THEN: masking should succeed, and the new image should have the same properties
    XCTAssertTrue(CGSizeEqualToSize(img.size, imgMasked.size), @"Image sizes should be equal");
    
    XCTAssertEqual(img.scale, imgMasked.scale, @"Image scales should be equal");
    
    XCTAssertThrows([img jsq_imageMaskedWithColor:nil], @"Should throw when passing nil color");
}

- (void)testImageAssets
{
    // GIVEN: our image assets
    
    // WHEN: we create a new UIImage object
    
    // THEN: the image is created successfully
    
    XCTAssertNotNil([UIImage jsq_bubbleRegularImage]);
    
    XCTAssertNotNil([UIImage jsq_bubbleRegularTaillessImage]);
    
    XCTAssertNotNil([UIImage jsq_bubbleRegularStrokedImage]);
    
    XCTAssertNotNil([UIImage jsq_bubbleRegularStrokedTaillessImage]);
    
    XCTAssertNotNil([UIImage jsq_bubbleCompactImage]);
    
    XCTAssertNotNil([UIImage jsq_bubbleCompactTaillessImage]);
    
    XCTAssertNotNil([UIImage jsq_defaultAccessoryImage]);
    
    XCTAssertNotNil([UIImage jsq_defaultTypingIndicatorImage]);
    
    XCTAssertNotNil([UIImage jsq_defaultPlayImage]);
}

@end
