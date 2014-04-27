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

#import "JSQMessagesViewController.h"
#import "JSQDemoViewController.h"


@interface JSQMessagesViewControllerTests : XCTestCase
@end


@implementation JSQMessagesViewControllerTests

- (void)testJSQMessagesViewControllerInit
{
    UINib *nib = [JSQMessagesViewController nib];
    XCTAssertNotNil(nib, @"Nib should not be nil");
    
    JSQMessagesViewController *vc = [JSQMessagesViewController messagesViewController];
    XCTAssertNotNil(vc, @"View controller should not be nil");
    XCTAssertNotNil(vc.view, @"View should not be nil");
    XCTAssertNotNil(vc.collectionView, @"Collection view should not be nil");
    XCTAssertNotNil(vc.inputToolbar, @"Input toolbar should not be nil");
 
    XCTAssertEqualObjects(vc.sender, @"JSQDefaultSender", @"Property should be equal to default value");
    XCTAssertEqual(vc.automaticallyAdjustsScrollViewInsets, YES, @"Property should be equal to default value");
    XCTAssertEqualObjects(vc.incomingCellIdentifier, [JSQMessagesCollectionViewCellIncoming cellReuseIdentifier], @"Property should be equal to default value");
    XCTAssertEqualObjects(vc.outgoingCellIdentifier, [JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier], @"Property should be equal to default value");
    XCTAssertEqualObjects(vc.typingIndicatorColor, [UIColor jsq_messageBubbleLightGrayColor], @"Property should be equal to default value");
    XCTAssertEqual(vc.showTypingIndicator, NO, @"Property should be equal to default value");
    XCTAssertEqual(vc.showLoadEarlierMessagesHeader, NO, @"Property should be equal to default value");
}

- (void)testJSQMessagesViewControllerSubclassInitProgramatically
{
    JSQDemoViewController *demoVC = [JSQDemoViewController messagesViewController];
    XCTAssertNotNil(demoVC, @"View controller should not be nil");
    XCTAssertTrue([demoVC isKindOfClass:[JSQDemoViewController class]], @"View controller should be kind of class: %@", [JSQDemoViewController class]);
    XCTAssertNotNil(demoVC.view, @"View should not be nil");
    XCTAssertNotNil(demoVC.collectionView, @"Collection view should not be nil");
    XCTAssertNotNil(demoVC.inputToolbar, @"Input toolbar should not be nil");
}

- (void)testJSQMessagesViewControllerSubclassInitStoryboards
{
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    XCTAssertNotNil(mainSB, @"Storyboard should not be nil");
    
    JSQDemoViewController *demoVC = [mainSB instantiateViewControllerWithIdentifier:@"DemoVC"];
    XCTAssertNotNil(demoVC, @"View controller should not be nil");
    XCTAssertTrue([demoVC isKindOfClass:[JSQDemoViewController class]], @"View controller should be kind of class: %@", [JSQDemoViewController class]);
    XCTAssertNotNil(demoVC.view, @"View should not be nil");
    XCTAssertNotNil(demoVC.collectionView, @"Collection view should not be nil");
    XCTAssertNotNil(demoVC.inputToolbar, @"Input toolbar should not be nil");
}

@end
