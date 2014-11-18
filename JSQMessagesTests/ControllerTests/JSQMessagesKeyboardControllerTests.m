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

#import "JSQMessagesKeyboardController.h"


@interface JSQMessagesKeyboardControllerTests : XCTestCase
@end


@implementation JSQMessagesKeyboardControllerTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testKeyboardControllerInit
{
    JSQMessagesKeyboardController *keyboardController = [[JSQMessagesKeyboardController alloc] initWithTextView:[UITextView new]
                                                                                                    contextView:[UIView new]
                                                                                           panGestureRecognizer:[UIPanGestureRecognizer new]
                                                                                                       delegate:nil];
    XCTAssertNotNil(keyboardController, @"Keyboard controller should not be nil");
    
    XCTAssertThrows([[JSQMessagesKeyboardController alloc] initWithTextView:nil
                                                                contextView:nil
                                                       panGestureRecognizer:nil
                                                                   delegate:nil], @"Invalid init should throw");
}

@end
