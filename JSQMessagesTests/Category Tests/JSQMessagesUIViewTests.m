//
//  Created by Jesse Squires
//  http://www.hexedbits.com
//
//
//  The MIT License
//  Copyright (c) 2014 Jesse Squires
//  http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>

#import "UIView+JSQMessages.h"


@interface JSQMessagesUIViewTests : XCTestCase
@end


@implementation JSQMessagesUIViewTests

- (void)testViewAutoLayoutPinEdges
{
    UIView *superview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    
    [superview addSubview:subview];
    XCTAssertNoThrow([superview jsq_pinAllEdgesOfSubview:subview], @"Pinning edges of subview to superview should not throw");
    
    XCTAssertEqual([[superview constraints] count], 4, @"Superview should have 4 constraints");
    
    XCTAssertEqual([[subview constraints] count], 0, @"Subview should have 0 constaitns");
    
    for (NSLayoutConstraint *eachConstraint in [superview constraints]) {
        
        XCTAssertEqualObjects(eachConstraint.firstItem, superview, @"Constraint first item should be equal to superview");
        
        XCTAssertEqualObjects(eachConstraint.secondItem, subview, @"Constraint second item should be equal to subview");
        
        XCTAssertEqual(eachConstraint.relation, NSLayoutRelationEqual, @"Constraint relation should be NSLayoutRelationEqual");
        
        XCTAssertEqual(eachConstraint.multiplier, 1.0f, @"Constraint multiplier should be 1.0");
        
        XCTAssertEqual(eachConstraint.constant, 0.0f, @"Constraint constant should be 1.0");
    }
}

@end
