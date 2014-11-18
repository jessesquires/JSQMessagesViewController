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

#import "UIColor+JSQMessages.h"


@interface JSQMessagesUIColorTests : XCTestCase
@end


@implementation JSQMessagesUIColorTests

- (void)testDarkeningColors
{
    // GIVEN: a color and darkening value
    CGFloat r = 0.89f, g = 0.34f, b = 0.67f, a = 1.0f;
    CGFloat darkeningValue = 0.12f;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:a];
    
    // WHEN: we darken that color
    UIColor *darkColor = [color jsq_colorByDarkeningColorWithValue:darkeningValue];
    
    // THEN: each RGB value is changed accordingly
    CGFloat dr, dg, db, da;
    [darkColor getRed:&dr green:&dg blue:&db alpha:&da];
    
    XCTAssertEqual(dr, r - darkeningValue, @"Red values should be equal");
    XCTAssertEqual(dg, g - darkeningValue, @"Green values should be equal");
    XCTAssertEqual(db, b - darkeningValue, @"Blue values should be equal");
    XCTAssertEqual(da, a, @"Alpha values should be equal");
}

- (void)testDarkeningColorsFloorToZero
{
    // GIVEN: a color and darkening value
    CGFloat r = 0.89f, g = 0.24f, b = 0.67f, a = 1.0f;
    CGFloat darkeningValue = 0.5f;
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:a];
    
    // WHEN: we dark that color, such that some RGB values will be negative
    UIColor *darkColor = [color jsq_colorByDarkeningColorWithValue:darkeningValue];
    
    // THEN: the RGB values are floored to zero instead of being negative
    CGFloat dr, dg, db, da;
    [darkColor getRed:&dr green:&dg blue:&db alpha:&da];
    XCTAssertEqual(dr, r - darkeningValue, @"Red values should be equal");
    XCTAssertEqual(dg, 0.0f, @"Green values should be floored to zero");
    XCTAssertEqual(db, b - darkeningValue, @"Blue values should be equal");
    XCTAssertEqual(da, a, @"Alpha values should be equal");
}

@end
