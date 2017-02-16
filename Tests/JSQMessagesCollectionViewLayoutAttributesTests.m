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

@interface JSQMessagesCollectionViewLayoutAttributesTests : XCTestCase

@end


@implementation JSQMessagesCollectionViewLayoutAttributesTests

- (void)testLayoutAttributesInitAndIsEqual
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    JSQMessagesCollectionViewLayoutAttributes *attrs = [JSQMessagesCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.messageBubbleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    attrs.messageBubbleContainerViewWidth = 40.0f;
    attrs.textViewTextContainerInsets = UIEdgeInsetsMake(10.0f, 8.0f, 10.0f, 8.0f);
    attrs.textViewFrameInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
    attrs.incomingAvatarViewSize = CGSizeMake(34.0f, 34.0f);
    attrs.outgoingAvatarViewSize = CGSizeZero;
    attrs.cellTopLabelHeight = 20.0f;
    attrs.messageBubbleTopLabelHeight = 10.0f;
    attrs.cellBottomLabelHeight = 15.0f;
    XCTAssertNotNil(attrs, @"Layout attributes should not be nil");
    
    JSQMessagesCollectionViewLayoutAttributes *copy = [attrs copy];
    XCTAssertEqualObjects(attrs, copy, @"Copied attributes should be equal");
    XCTAssertEqual([attrs hash], [copy hash], @"Copied attributes hashes should be equal");
}

@end
