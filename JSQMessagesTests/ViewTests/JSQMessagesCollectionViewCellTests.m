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

#import "JSQMessagesCollectionViewCellIncoming.h"
#import "JSQMessagesCollectionViewPhotoCellIncoming.h"
#import "JSQMessagesCollectionViewVideoCellIncoming.h"
#import "JSQMessagesCollectionViewAudioCellIncoming.h"
#import "JSQMessagesCollectionViewCellOutgoing.h"
#import "JSQMessagesCollectionViewPhotoCellOutgoing.h"
#import "JSQMessagesCollectionViewVideoCellOutgoing.h"
#import "JSQMessagesCollectionViewAudioCellOutgoing.h"

@interface JSQMessagesCollectionViewCellTests : XCTestCase
@end


@implementation JSQMessagesCollectionViewCellTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testMessagesCollectionViewCellInit
{
    UINib *incomingCell = [JSQMessagesCollectionViewCellIncoming nib];
    XCTAssertNotNil(incomingCell, @"Nib should not be nil");
    
    NSString *incomingCellId = [JSQMessagesCollectionViewCellIncoming cellReuseIdentifier];
    XCTAssertNotNil(incomingCellId, @"Cell identifier should not be nil");
    
    UINib *incomingPhotoCell = [JSQMessagesCollectionViewPhotoCellIncoming nib];
    XCTAssertNotNil(incomingPhotoCell, @"Nib should not be nil");
    
    NSString *incomingPhotoCellId = [JSQMessagesCollectionViewPhotoCellIncoming cellReuseIdentifier];
    XCTAssertNotNil(incomingPhotoCellId, @"Cell identifier should not be nil");
    
    UINib *incomingVideoCell = [JSQMessagesCollectionViewVideoCellIncoming nib];
    XCTAssertNotNil(incomingVideoCell, @"Nib should not be nil");
    
    NSString *incomingVideoCellId = [JSQMessagesCollectionViewVideoCellIncoming cellReuseIdentifier];
    XCTAssertNotNil(incomingVideoCellId, @"Cell identifier should not be nil");
    
    UINib *incomingAudioCell = [JSQMessagesCollectionViewAudioCellIncoming nib];
    XCTAssertNotNil(incomingAudioCell, @"Nib should not be nil");
    
    NSString *incomingAudioCellId = [JSQMessagesCollectionViewAudioCellIncoming cellReuseIdentifier];
    XCTAssertNotNil(incomingAudioCellId, @"Cell identifier should not be nil");
    
    
    UINib *outgoingCell = [JSQMessagesCollectionViewCellOutgoing nib];
    XCTAssertNotNil(outgoingCell, @"Nib should not be nil");
    
    NSString *outgoingCellId = [JSQMessagesCollectionViewCellOutgoing cellReuseIdentifier];
    XCTAssertNotNil(outgoingCellId, @"Cell identifier should not be nil");
    
    UINib *outgoingPhotoCell = [JSQMessagesCollectionViewPhotoCellOutgoing nib];
    XCTAssertNotNil(outgoingPhotoCell, @"Nib should not be nil");
    
    NSString *outgoingPhotoCellId = [JSQMessagesCollectionViewPhotoCellOutgoing cellReuseIdentifier];
    XCTAssertNotNil(outgoingPhotoCellId, @"Cell identifier should not be nil");
    
    UINib *outgoingVideoCell = [JSQMessagesCollectionViewVideoCellOutgoing nib];
    XCTAssertNotNil(outgoingVideoCell, @"Nib should not be nil");
    
    NSString *outgoingVideoCellId = [JSQMessagesCollectionViewVideoCellOutgoing cellReuseIdentifier];
    XCTAssertNotNil(outgoingVideoCellId, @"Cell identifier should not be nil");
    
    UINib *outgoingAudioCell = [JSQMessagesCollectionViewAudioCellOutgoing nib];
    XCTAssertNotNil(outgoingAudioCell, @"Nib should not be nil");
    
    NSString *outgoingAudioCellId = [JSQMessagesCollectionViewAudioCellOutgoing cellReuseIdentifier];
    XCTAssertNotNil(outgoingAudioCellId, @"Cell identifier should not be nil");
}

@end
