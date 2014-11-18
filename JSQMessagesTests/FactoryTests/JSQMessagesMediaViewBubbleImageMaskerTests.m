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

#import "JSQMessagesMediaViewBubbleImageMasker.h"


@interface JSQMessagesMediaViewBubbleImageMaskerTests : XCTestCase
@end


@implementation JSQMessagesMediaViewBubbleImageMaskerTests

- (void)testMediaViewBubbleImageMasker
{
    // GIVEN: a new masker object
    JSQMessagesMediaViewBubbleImageMasker *masker = [[JSQMessagesMediaViewBubbleImageMasker alloc] init];
    XCTAssertNotNil(masker);
    
    // WHEN: we apply a mask to a view
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    // THEN: it succeeds without an error
    XCTAssertNoThrow([masker applyOutgoingBubbleImageMaskToMediaView:view1]);
    XCTAssertNoThrow([masker applyIncomingBubbleImageMaskToMediaView:view2]);
}

@end
