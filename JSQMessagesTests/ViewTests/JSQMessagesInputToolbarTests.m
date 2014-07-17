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

#import "JSQMessagesViewController.h"
#import "JSQMessagesInputToolbar.h"


@interface JSQMessagesInputToolbarTests : XCTestCase
@end


@implementation JSQMessagesInputToolbarTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testInputToolbarInit
{
    JSQMessagesViewController *vc = [JSQMessagesViewController messagesViewController];
    [vc loadView];
    
    JSQMessagesInputToolbar *toolbar = vc.inputToolbar;
    XCTAssertNotNil(toolbar, @"Toolbar should not be nil");
    XCTAssertNotNil(toolbar.contentView, @"Toolbar content view should not be nil");
}

@end
