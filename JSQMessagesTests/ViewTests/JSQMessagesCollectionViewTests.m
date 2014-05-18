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

#import "JSQMessagesCollectionView.h"
#import "JSQMessagesCollectionViewFlowLayout.h"


@interface JSQMessagesCollectionViewTests : XCTestCase
@end


@implementation JSQMessagesCollectionViewTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCollectionViewInit
{
    JSQMessagesCollectionViewFlowLayout *layout = [[JSQMessagesCollectionViewFlowLayout alloc] init];
    
    JSQMessagesCollectionView *view = [[JSQMessagesCollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                                  collectionViewLayout:layout];
    
    XCTAssertNotNil(view, @"Collection view should not be nil");
    XCTAssertEqualObjects(view.backgroundColor, [UIColor whiteColor], @"Property should be equal to default value");
    XCTAssertEqual(view.keyboardDismissMode, UIScrollViewKeyboardDismissModeInteractive, @"Property should be equal to default value");
    XCTAssertEqual(view.alwaysBounceVertical, YES, @"Property should be equal to default value");
    XCTAssertEqual(view.bounces, YES, @"Property should be equal to default value");
}

@end
