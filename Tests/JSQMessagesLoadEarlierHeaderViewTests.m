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

@interface JSQMessagesLoadEarlierHeaderViewTests : XCTestCase

@end

@implementation JSQMessagesLoadEarlierHeaderViewTests

- (void)testLoadEarlierHeaderViewInit
{
    UINib *headerView = [JSQMessagesLoadEarlierHeaderView nib];
    XCTAssertNotNil(headerView, @"Nib should not be nil");
    
    NSString *headerId = [JSQMessagesLoadEarlierHeaderView headerReuseIdentifier];
    XCTAssertNotNil(headerId, @"Header view identifier should not be nil");
}

@end
