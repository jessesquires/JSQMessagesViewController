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

@property (strong, nonatomic) JSQMessagesAvatarImageFactory *factory;
@property (assign, nonatomic) NSUInteger avatarDiameter;

@end


@implementation JSQMessagesAvatarImageFactoryTests

- (void)setUp
{
    [super setUp];
    self.avatarDiameter = 50.0f;
    self.factory = [[JSQMessagesAvatarImageFactory alloc] initWithDiameter:self.avatarDiameter];
}

- (void)tearDown
{
    [super tearDown];
    self.factory = nil;
}

- (CGSize)avatarSize
{
    return CGSizeMake(self.avatarDiameter, self.avatarDiameter);
}

- (void)testAvatarImage
{
    UIImage *image = [UIImage imageNamed:@"demo_avatar_jobs"];
    XCTAssertNotNil(image, @"Image should not be nil");
    
    JSQMessagesAvatarImage *avatar = [self.factory avatarImageWithPlaceholder:image];
    
    XCTAssertNotNil(avatar, @"Avatar should not be nil");
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarPlaceholderImage.size, [self avatarSize]), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarPlaceholderImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
    
    avatar.avatarImage = [self.factory circularAvatarImage:image];
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarImage.size, [self avatarSize]), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
    
    avatar.avatarHighlightedImage = [self.factory circularAvatarHighlightedImage:image];
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarHighlightedImage.size, [self avatarSize]), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarHighlightedImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
}

- (void)testAvatarInitialsImage
{
    JSQMessagesAvatarImage *avatar = [self.factory avatarImageWithUserInitials:@"JSQ"
                                                               backgroundColor:[UIColor lightGrayColor]
                                                                     textColor:[UIColor darkGrayColor]
                                                                          font:[UIFont systemFontOfSize:13.0f]];
    
    XCTAssertNotNil(avatar, @"Avatar should not be nil");
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarImage.size, [self avatarSize]), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
    
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarHighlightedImage.size, [self avatarSize]), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarHighlightedImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
    
    XCTAssertTrue(CGSizeEqualToSize(avatar.avatarPlaceholderImage.size, [self avatarSize]), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.avatarPlaceholderImage.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
}

@end
