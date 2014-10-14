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

#import "UIView+JSQMessages.h"


@interface JSQMessagesUIViewTests : XCTestCase
@end


@implementation JSQMessagesUIViewTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testViewAutoLayoutPinEdges
{
    UIView *superview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    
    [superview addSubview:subview];
    XCTAssertNoThrow([superview jsq_pinAllEdgesOfSubview:subview], @"Pinning edges of subview to superview should not throw");
    
    XCTAssertEqual([[superview constraints] count], 4U, @"Superview should have 4 constraints");
    
    XCTAssertEqual([[subview constraints] count], 0U, @"Subview should have 0 constraints");
    
    for (NSLayoutConstraint *eachConstraint in [superview constraints]) {
        
        XCTAssertEqualObjects(eachConstraint.firstItem, superview, @"Constraint first item should be equal to superview");
        
        XCTAssertEqualObjects(eachConstraint.secondItem, subview, @"Constraint second item should be equal to subview");
        
        XCTAssertEqual(eachConstraint.relation, NSLayoutRelationEqual, @"Constraint relation should be NSLayoutRelationEqual");
        
        XCTAssertEqual(eachConstraint.multiplier, 1.0f, @"Constraint multiplier should be 1.0");
        
        XCTAssertEqual(eachConstraint.constant, 0.0f, @"Constraint constant should be 0.0");
    }
}

@end
