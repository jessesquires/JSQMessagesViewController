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

#import "JSQMessagesCollectionViewFlowLayout.h"


@interface JSQMessagesCollectionViewFlowLayoutTests : XCTestCase
@end


@implementation JSQMessagesCollectionViewFlowLayoutTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testFlowLayoutInit
{
    JSQMessagesCollectionViewFlowLayout *layout = [[JSQMessagesCollectionViewFlowLayout alloc] init];
    XCTAssertNotNil(layout, @"Layout should not be nil");
    
    XCTAssertEqual(layout.scrollDirection, UICollectionViewScrollDirectionVertical, @"Property should be equal to default value");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(layout.sectionInset, UIEdgeInsetsMake(10.0f, 4.0f, 10.0f, 4.0f)), @"Property should be equal to default value");
    XCTAssertEqual(layout.minimumLineSpacing, 4.0f, @"Property should be equal to default value");
    
    XCTAssertEqual(layout.springinessEnabled, NO, @"Property should be equal to default value");
    XCTAssertEqual(layout.springResistanceFactor, 1000U, @"Property should be equal to default value");
    XCTAssertEqualObjects(layout.messageBubbleFont, [UIFont systemFontOfSize:15.0f], @"Property should be equal to default value");
    XCTAssertEqual(layout.messageBubbleLeftRightMargin, 40.0f, @"Property should be equal to default value");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(layout.messageBubbleTextViewFrameInsets, UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f)), @"Property should be equal to default value");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(layout.messageBubbleTextViewTextContainerInsets, UIEdgeInsetsMake(10.0f, 8.0f, 10.0f, 8.0f)), @"Property should be equal to default value");
    XCTAssertTrue(CGSizeEqualToSize(layout.incomingAvatarViewSize, CGSizeMake(34.0f, 34.0f)), @"Property should be equal to default value");
    XCTAssertTrue(CGSizeEqualToSize(layout.outgoingAvatarViewSize, CGSizeMake(34.0f, 34.0f)), @"Property should be equal to default value");
}

@end
