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

#import "JSQMessagesToolbarButtonFactory.h"

#import "UIColor+JSQMessages.h"


@interface JSQMessagesToolbarButtonFactoryTests : XCTestCase
@end


@implementation JSQMessagesToolbarButtonFactoryTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testDefaultSendButtonItem
{
    UIButton *button = [JSQMessagesToolbarButtonFactory defaultSendButtonItem];
    XCTAssertNotNil(button, @"Button should not be nil");
    
    XCTAssertTrue(CGRectEqualToRect(button.frame, CGRectZero), @"Button initial frame should equal CGRectZero");
    
    NSString *title = @"Send";
    XCTAssertEqualObjects([button titleForState:UIControlStateNormal], title, @"Button title should equal %@", title);
    XCTAssertNil(button.imageView.image, @"Button image should be nil");
    
    XCTAssertEqualObjects([button titleColorForState:UIControlStateNormal], [UIColor jsq_messageBubbleBlueColor], @"Button normal title color should be set");
    XCTAssertEqualObjects([button titleColorForState:UIControlStateHighlighted], [[UIColor jsq_messageBubbleBlueColor] jsq_colorByDarkeningColorWithValue:0.1f], @"Button highlighted title color should be set");
    XCTAssertEqualObjects([button titleColorForState:UIControlStateDisabled], [UIColor lightGrayColor], @"Button disabled title color should be set");
    
    XCTAssertEqualObjects(button.titleLabel.font, [UIFont boldSystemFontOfSize:17.0f], @"Button font should be set");
    XCTAssertEqual(button.contentMode, UIViewContentModeCenter, @"Button content mode should be set");
    XCTAssertEqualObjects(button.backgroundColor, [UIColor clearColor], @"Button background color should be set");
    XCTAssertEqualObjects(button.tintColor, [UIColor jsq_messageBubbleBlueColor], @"Button tint color should be set");
}

- (void)testDefaultAccessoryButtonItem
{
    UIButton *button = [JSQMessagesToolbarButtonFactory defaultAccessoryButtonItem];
    XCTAssertNotNil(button, @"Button should not be nil");
    
    XCTAssertTrue(CGRectEqualToRect(button.frame, CGRectZero), @"Button frame should equal CGRectZero");
    
    XCTAssertNil(button.titleLabel.text, @"Button title should be nil");
    XCTAssertNotNil([button imageForState:UIControlStateNormal], @"Button normal image should not be nil");
    XCTAssertNotNil([button imageForState:UIControlStateHighlighted], @"Button highlighted image should not be nil");
    
    XCTAssertEqual(button.contentMode, UIViewContentModeScaleAspectFit, @"Button content mode should be set");
    XCTAssertEqualObjects(button.backgroundColor, [UIColor clearColor], @"Button background color should be set");
    XCTAssertEqualObjects(button.tintColor, [UIColor lightGrayColor], @"Button tint color should be set");
}

@end
