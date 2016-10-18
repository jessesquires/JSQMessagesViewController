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

@interface JSQMessagesTypingIndicatorFooterViewTests : XCTestCase

@end


@implementation JSQMessagesTypingIndicatorFooterViewTests

- (void)testTypingIndicatorFooterViewInit
{
    UINib *footerView = [JSQMessagesTypingIndicatorFooterView nib];
    XCTAssertNotNil(footerView, @"Nib should not be nil");
    
    NSString *footerId = [JSQMessagesTypingIndicatorFooterView footerReuseIdentifier];
    XCTAssertNotNil(footerId, @"Footer view identifier should not be nil");
}

@end
