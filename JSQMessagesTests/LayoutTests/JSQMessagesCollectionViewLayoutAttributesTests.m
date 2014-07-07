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

#import "JSQMessagesCollectionViewLayoutAttributes.h"


@interface JSQMessagesCollectionViewLayoutAttributesTests : XCTestCase
@end


@implementation JSQMessagesCollectionViewLayoutAttributesTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testLayoutAttributesInitAndIsEqual
{
    UIButton *incommingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [incommingButton setImage:[UIImage imageNamed:@"demo_play_button_in"] forState:UIControlStateNormal];
    [incommingButton sizeToFit];
    
    UIButton *outgoingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [outgoingButton setImage:[UIImage imageNamed:@"demo_play_button_out"] forState:UIControlStateNormal];
    [outgoingButton sizeToFit];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    JSQMessagesCollectionViewLayoutAttributes *attrs = [JSQMessagesCollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.messageBubbleFont = [UIFont systemFontOfSize:15.0f];
    attrs.messageBubbleLeftRightMargin = 40.0f;
    attrs.textViewTextContainerInsets = UIEdgeInsetsMake(10.0f, 8.0f, 10.0f, 8.0f);
    attrs.textViewFrameInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
    attrs.incomingAvatarViewSize = CGSizeMake(34.0f, 34.0f);
    attrs.outgoingAvatarViewSize = CGSizeZero;
    attrs.cellTopLabelHeight = 20.0f;
    attrs.messageBubbleTopLabelHeight = 10.0f;
    attrs.cellBottomLabelHeight = 15.0f;
    attrs.incomingThumbnailImageSize = CGSizeMake(120.f, 160.f);
    attrs.outgoingThumbnailImageSize = CGSizeMake(120.f, 160.f);
    attrs.incomingVideoThumbnailSize = CGSizeMake(120.f, 160.f);
    attrs.outgoingVideoThumbnailSize = CGSizeMake(120.f, 160.f);
    attrs.incomingAudioPlayerViewSize = CGSizeMake(150.f, 40.f);
    attrs.outgoingAudioPlayerViewSize = CGSizeMake(150.f, 40.f);
    attrs.incomingVideoOverlayViewSize = CGSizeMake(40.f, 40.f);
    attrs.outgoingVideoOverlayViewSize = CGSizeMake(40.f, 40.f);
    attrs.incomingPhotoActivityIndicatorViewSize = CGSizeMake(20.f, 20.f);
    attrs.outgoingPhotoActivityIndicatorViewSize = CGSizeMake(20.f, 20.f);
    attrs.incomingVideoActivityIndicatorViewSize = CGSizeMake(20.f, 20.f);
    attrs.outgoingVideoActivityIndicatorViewSize = CGSizeMake(20.f, 20.f);
    attrs.incomingAudioActivityIndicatorViewSize = CGSizeMake(20.f, 20.f);
    attrs.outgoingAudioActivityIndicatorViewSize = CGSizeMake(20.f, 20.f);
    
    
    XCTAssertNotNil(attrs, @"Layout attributes should not be nil");
    
    JSQMessagesCollectionViewLayoutAttributes *copy = [attrs copy];
    XCTAssertEqualObjects(attrs, copy, @"Copied attributes should be equal");
    XCTAssertEqual([attrs hash], [copy hash], @"Copied attributes hashes should be equal");
}

@end
