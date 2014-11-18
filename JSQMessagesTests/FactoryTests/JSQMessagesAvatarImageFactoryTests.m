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

#import "JSQMessagesAvatarImageFactory.h"


@interface JSQMessagesAvatarImageFactoryTests : XCTestCase
@end


@implementation JSQMessagesAvatarImageFactoryTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testAvatarImage
{
    UIImage *image = [UIImage imageNamed:@"demo_avatar_jobs"];
    XCTAssertNotNil(image, @"Image should not be nil");
    
    CGFloat diameter = 50.0f;
    JSQMessagesAvatarImage *avatar = [JSQMessagesAvatarImageFactory avatarImageWithPlaceholder:image diameter:diameter];
    
    XCTAssertNotNil(avatar, @"Avatar should not be nil");
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarPlaceholderImage.size, CGSizeMake(diameter, diameter)), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarPlaceholderImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
    
    avatar.avatarImage = [JSQMessagesAvatarImageFactory circularAvatarImage:image withDiameter:diameter];
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarImage.size, CGSizeMake(diameter, diameter)), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
    
    avatar.avatarHighlightedImage = [JSQMessagesAvatarImageFactory circularAvatarHighlightedImage:image withDiameter:diameter];
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarHighlightedImage.size, CGSizeMake(diameter, diameter)), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarHighlightedImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
}

- (void)testAvatarInitialsImage
{
    CGFloat diameter = 50.0f;
    JSQMessagesAvatarImage *avatar = [JSQMessagesAvatarImageFactory avatarImageWithUserInitials:@"JSQ"
                                                                                backgroundColor:[UIColor lightGrayColor]
                                                                                      textColor:[UIColor darkGrayColor]
                                                                                           font:[UIFont systemFontOfSize:13.0f]
                                                                                       diameter:diameter];
    
    XCTAssertNotNil(avatar, @"Avatar should not be nil");
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarImage.size, CGSizeMake(diameter, diameter)), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
    
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarHighlightedImage.size, CGSizeMake(diameter, diameter)), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarHighlightedImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
    
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarPlaceholderImage.size, CGSizeMake(diameter, diameter)), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarPlaceholderImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
}

@end
