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

#import "UIImage+JSQMessages.h"


@interface JSQMessagesUIImageTests : XCTestCase
@end


@implementation JSQMessagesUIImageTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testImageMasking
{
    UIImage *img = [UIImage imageNamed:@"bubble_min"];
    XCTAssertNotNil(img, @"Image should not be nil");
    
    UIImage *imgMasked = [img jsq_imageMaskedWithColor:[UIColor whiteColor]];
    XCTAssertNotNil(imgMasked, @"Image should not be nil");
    
    XCTAssertTrue(CGSizeEqualToSize(img.size, imgMasked.size), @"Image sizes should be equal");
    
    XCTAssertEqual(img.scale, imgMasked.scale, @"Image scales should be equal");
    
    XCTAssertThrows([img jsq_imageMaskedWithColor:nil], @"Should throw when passing nil color");
}

@end
