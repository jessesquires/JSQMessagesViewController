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

#import "JSQMessagesViewController.h"
#import "JSQMessagesInputToolbar.h"
#import "DemoMessagesViewController.h"


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
    XCTAssertEqual(toolbar.sendButtonOnRight, YES, @"Property should be equal to default value");
}

- (void)testSetMaximumHeightOfInputToolbar
{
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    XCTAssertNotNil(mainSB, @"Storyboard should not be nil");

    DemoMessagesViewController *demoVC = [mainSB instantiateViewControllerWithIdentifier:@"DemoVC"];
    [demoVC view];

    XCTAssertEqual(demoVC.maximumInputToolbarHeight, (NSUInteger) NSNotFound, @"maximumInputToolbarHeight is not set to NSNotFound");

    CGRect newBounds = demoVC.inputToolbar.bounds;
    newBounds.size.height = 100;
    demoVC.inputToolbar.bounds = newBounds;
    XCTAssertEqual(demoVC.inputToolbar.bounds.size.height, 100);

    demoVC.maximumInputToolbarHeight = 54;
    [demoVC viewDidLoad];
    XCTAssertLessThanOrEqual(demoVC.inputToolbar.bounds.size.height, 54, @"maximumInputToolbarHeight not honored");
}

@end
