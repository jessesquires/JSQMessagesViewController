//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright © 2014-present Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>
#import <JSQMessagesViewController/JSQMessagesViewController.h>

@interface JSQMessagesInputToolbarTests : XCTestCase
@end


@implementation JSQMessagesInputToolbarTests

- (void)testInputToolbarInit
{
    JSQMessagesViewController *vc = [JSQMessagesViewController messagesViewController];
    [vc loadView];

    JSQMessagesInputToolbar *toolbar = vc.inputToolbar;
    XCTAssertNotNil(toolbar, @"Toolbar should not be nil");
    XCTAssertNotNil(toolbar.contentView, @"Toolbar content view should not be nil");
    XCTAssertEqual(toolbar.sendButtonLocation, JSQMessagesInputSendButtonLocationRight, @"Property should be equal to default value");
}

// TODO: investigate this later
//- (void)disabled_testSetMaximumHeight
//{
//    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    XCTAssertNotNil(mainSB, @"Storyboard should not be nil");
//
//    DemoMessagesViewController *demoVC = [mainSB instantiateViewControllerWithIdentifier:@"DemoVC"];
//    [demoVC beginAppearanceTransition:YES animated:NO];
//    [demoVC endAppearanceTransition];
//
//    XCTAssertEqual(demoVC.inputToolbar.maximumHeight, NSNotFound, @"maximumInputToolbarHeight should equal default value");
//
//    demoVC.inputToolbar.maximumHeight = 54;
//
//    CGRect newBounds = demoVC.inputToolbar.bounds;
//    newBounds.size.height = 100;
//    demoVC.inputToolbar.bounds = newBounds;
//    XCTAssertEqual(CGRectGetHeight(demoVC.inputToolbar.bounds), 100);
//
//    [demoVC.view setNeedsUpdateConstraints];
//    [demoVC.view setNeedsLayout];
//    [demoVC.view layoutIfNeeded];
//
//    XCTAssertLessThanOrEqual(CGRectGetHeight(demoVC.inputToolbar.frame), 54, @"Toolbar height should be <= to maximumInputToolbarHeight");
//}

@end
