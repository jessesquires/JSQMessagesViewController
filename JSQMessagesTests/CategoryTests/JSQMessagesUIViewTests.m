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

#import "UIView+JSQMessages.h"


@interface JSQMessagesUIViewTests : XCTestCase
@end


@implementation JSQMessagesUIViewTests

- (void)testViewAutoLayoutPinEdges
{
    // GIVEN: a superview and subview
    UIView *superview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 50.0f)];
    [superview setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 25.0f, 25.0f)];
    [subview setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // WHEN: we add the subview to the superview
    [superview addSubview:subview];
    
    // WHEN: we pin the edges of the subview to the superview
    XCTAssertNoThrow([superview jsq_pinAllEdgesOfSubview:subview], @"Pinning edges of subview to superview should not throw");
    [superview setNeedsUpdateConstraints];
    [superview layoutIfNeeded];
    
    // THEN: add the layout constraints and laying out the views succeeds
    
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
