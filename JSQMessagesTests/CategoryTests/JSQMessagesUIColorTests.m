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

#import "UIColor+JSQMessages.h"


@interface JSQMessagesUIColorTests : XCTestCase
@end


@implementation JSQMessagesUIColorTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGreenColor
{
    CGFloat h, s, b, a;
    
    UIColor *green = [UIColor jsq_messageBubbleGreenColor];
    XCTAssertNotNil(green, @"Color should not be nil");
    
    [green getHue:&h saturation:&s brightness:&b alpha:&a];
    UIColor *copyGreen = [UIColor colorWithHue:h saturation:s brightness:b alpha:a];
    XCTAssertEqualObjects(green, copyGreen, @"Colors should be equal");
}

- (void)testBlueColor
{
    CGFloat h, s, b, a;
    
    UIColor *blue = [UIColor jsq_messageBubbleBlueColor];
    XCTAssertNotNil(blue, @"Color should not be nil");
    
    [blue getHue:&h saturation:&s brightness:&b alpha:&a];
    UIColor *copyBlue = [UIColor colorWithHue:h saturation:s brightness:b alpha:a];
    XCTAssertEqualObjects(blue, copyBlue, @"Colors should be equal");
}

- (void)testGrayColor
{
    CGFloat h, s, b, a;
    
    UIColor *gray = [UIColor jsq_messageBubbleLightGrayColor];
    XCTAssertNotNil(gray, @"Color should not be nil");
    
    [gray getHue:&h saturation:&s brightness:&b alpha:&a];
    UIColor *copyGray = [UIColor colorWithHue:h saturation:s brightness:b alpha:a];
    XCTAssertEqualObjects(gray, copyGray, @"Colors should be equal");
}

- (void)testDarkeningColors
{
    CGFloat r = 0.89f, g = 0.34f, b = 0.67f, a = 1.0f;
    
    CGFloat darkeningValue = 0.12f;
    
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:a];
    UIColor *darkColor = [color jsq_colorByDarkeningColorWithValue:darkeningValue];
    
    CGFloat dr, dg, db, da;
    [darkColor getRed:&dr green:&dg blue:&db alpha:&da];
    XCTAssertEqual(dr, r - darkeningValue, @"Red values should be equal");
    XCTAssertEqual(dg, g - darkeningValue, @"Green values should be equal");
    XCTAssertEqual(db, b - darkeningValue, @"Blue values should be equal");
    XCTAssertEqual(da, a, @"Alpha values should be equal");
}

- (void)testDarkeningColorsFloorToZero
{
    CGFloat r = 0.89f, g = 0.24f, b = 0.67f, a = 1.0f;
    
    CGFloat darkeningValue = 0.5f;
    
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:a];
    UIColor *darkColor = [color jsq_colorByDarkeningColorWithValue:darkeningValue];
    
    CGFloat dr, dg, db, da;
    [darkColor getRed:&dr green:&dg blue:&db alpha:&da];
    XCTAssertEqual(dr, r - darkeningValue, @"Red values should be equal");
    XCTAssertEqual(dg, 0.0f, @"Green values should be floored to zero");
    XCTAssertEqual(db, b - darkeningValue, @"Blue values should be equal");
    XCTAssertEqual(da, a, @"Alpha values should be equal");
}

@end
