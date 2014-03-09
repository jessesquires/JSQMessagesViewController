//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSMessagesViewController
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>

#import "JSQMessagesViewController.h"


@interface JSQMessagesViewControllerTests : XCTestCase

@end



@implementation JSQMessagesViewControllerTests

- (void)setUp
{
    [super setUp];
    
}

- (void)tearDown
{
    
    [super tearDown];
}

- (void)testJSQMessagesInit
{
    UIStoryboard *sb = [JSQMessagesViewController messagesStoryboard];
    XCTAssertNotNil(sb, @"Storyboard should not be nil");
    
    id initialVC = [sb instantiateInitialViewController];
    XCTAssertNotNil(initialVC, @"Storyboard's intial view controller should not be nil");
    XCTAssertTrue([initialVC isKindOfClass:[JSQMessagesViewController class]], @"Initial view controller should be of type %@", [JSQMessagesViewController class]);
    
    JSQMessagesViewController *vc = [JSQMessagesViewController messagesViewController];
    XCTAssertNotNil(vc, @"Messages view controller should not be nil");
    
    XCTAssertNotNil(vc.collectionView, @"Collection view should not be nil");
    XCTAssertNotNil(vc.inputToolbar, @"Input toolbar should not be nil");
}

@end
