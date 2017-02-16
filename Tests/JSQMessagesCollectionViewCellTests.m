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


@interface JSQMessagesCollectionViewCellTests : XCTestCase

@end

@implementation JSQMessagesCollectionViewCellTests

- (void)testMessagesIncomingCollectionViewCellInit
{
    UINib *incomingCell = [JSQMessagesCollectionViewCellIncoming nib];
    XCTAssertNotNil(incomingCell, @"Nib should not be nil");
    
    NSString *incomingCellId = [JSQMessagesCollectionViewCellIncoming cellReuseIdentifier];
    XCTAssertNotNil(incomingCellId, @"Cell identifier should not be nil");
    XCTAssertEqualObjects(incomingCellId, NSStringFromClass([JSQMessagesCollectionViewCellIncoming class]));
}

- (void)testMessagesOutgoingCollectionViewCellInit
{
    UINib *outgoingCell = [JSQMessagesCollectionViewCellOutgoing nib];
    XCTAssertNotNil(outgoingCell, @"Nib should not be nil");
    
    NSString *outgoingCellId = [JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier];
    XCTAssertNotNil(outgoingCellId, @"Cell identifier should not be nil");
    XCTAssertEqualObjects(outgoingCellId, NSStringFromClass([JSQMessagesCollectionViewCellOutgoing class]));
}

@end
