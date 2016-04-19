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

- (void)testSetMaximumHeight
{
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    XCTAssertNotNil(mainSB, @"Storyboard should not be nil");

    DemoMessagesViewController *demoVC = [mainSB instantiateViewControllerWithIdentifier:@"DemoVC"];
    [demoVC beginAppearanceTransition:YES animated:NO];
    [demoVC endAppearanceTransition];

    XCTAssertEqual(demoVC.inputToolbar.maximumHeight, NSNotFound, @"maximumInputToolbarHeight should equal default value");

    demoVC.inputToolbar.maximumHeight = 54;

    CGRect newBounds = demoVC.inputToolbar.bounds;
    newBounds.size.height = 100;
    demoVC.inputToolbar.bounds = newBounds;
    XCTAssertEqual(CGRectGetHeight(demoVC.inputToolbar.bounds), 100);

    [demoVC.view setNeedsUpdateConstraints];
    [demoVC.view setNeedsLayout];
    [demoVC.view layoutIfNeeded];

    XCTAssertLessThanOrEqual(CGRectGetHeight(demoVC.inputToolbar.frame), 54, @"Toolbar height should be <= to maximumInputToolbarHeight");
}

@end
