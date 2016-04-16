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

#import "JSQMessagesTypingIndicatorFooterView.h"

@interface JSQMessagesTypingIndicatorFooterView (Testable)

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleImageViewRightHorizontalConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *typingIndicatorImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typingIndicatorImageViewRightHorizontalConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *typingIndicatorLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageViewToTypingIndicatorLabelHorizontalConstraint;

@end


@interface JSQMessagesTypingIndicatorFooterViewTests : XCTestCase {
    UINib *footerViewNib;
    JSQMessagesTypingIndicatorFooterView *footerView;
}
@end


@implementation JSQMessagesTypingIndicatorFooterViewTests

- (void)setUp
{
    [super setUp];
    footerViewNib = [JSQMessagesTypingIndicatorFooterView nib];
    footerView = [footerViewNib instantiateWithOwner:nil options:nil].firstObject;
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testTypingIndicatorFooterViewInit
{
    XCTAssertNotNil(footerViewNib, @"Nib should not be nil");
    
    NSString *footerId = [JSQMessagesTypingIndicatorFooterView footerReuseIdentifier];
    XCTAssertNotNil(footerId, @"Footer view identifier should not be nil");
}

- (void)testNibInstantiatesCorrectClass
{
    XCTAssertTrue([footerView isMemberOfClass:[JSQMessagesTypingIndicatorFooterView class]]);
}

- (void)testEllipsisImageNilIfConfiguredWithAvatarImage
{
    XCTAssertTrue(footerView.typingIndicatorImageView.image == nil);
}

- (void)testBubbleImageNilIfConfiguredWithAvatarImage
{
    [footerView configureWithAvatarImage:[UIImage new] message:nil textColor:nil font:nil];
    XCTAssertTrue(footerView.bubbleImageView.image == nil);
}

- (void)testTypingIndicatorLabelHiddenByDefault
{
    XCTAssertTrue(footerView.typingIndicatorLabel.hidden == YES);
}

- (void)testTypingIndicatorLabelNotHiddenIfConfiguredWithAvatarImage
{
    [footerView configureWithAvatarImage:[UIImage new] message:nil textColor:nil font:nil];
    XCTAssertTrue(footerView.typingIndicatorLabel.hidden == NO);
}

- (void)testConfigureWithMessageSetsLabelText
{
    [footerView configureWithAvatarImage:nil message:@"Test message" textColor:nil font:nil];
    XCTAssertEqualObjects(@"Test message", footerView.typingIndicatorLabel.text);
}

- (void)testSetsLabelTextColor
{
    [footerView configureWithAvatarImage:nil message:nil textColor:[UIColor greenColor] font:nil];
    XCTAssertEqualObjects([UIColor greenColor], footerView.typingIndicatorLabel.textColor);
}

- (void)testConfigureWithNilMessageDoesNotNilLabelText
{
    [footerView configureWithAvatarImage:[UIImage new] message:nil textColor:nil font:nil];
    XCTAssertNotNil(footerView.typingIndicatorLabel.text);
}

- (void)testConfigureWithNilImageSetsImageViewWidthToZero
{
    [footerView configureWithAvatarImage:nil message:@"Test message" textColor:nil font:nil];
    [footerView layoutIfNeeded];
    XCTAssertEqual(0, footerView.avatarImageView.bounds.size.width);
}

@end
