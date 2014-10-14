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

#import "JSQMessagesAvatarFactory.h"


@interface JSQMessagesAvatarFactoryTests : XCTestCase
@end


@implementation JSQMessagesAvatarFactoryTests

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
    UIImage *avatar = [JSQMessagesAvatarFactory avatarWithImage:image diameter:diameter];
    XCTAssertNotNil(avatar, @"Avatar should not be nil");
    XCTAssertTrue(CGSizeEqualToSize(avatar.size, CGSizeMake(diameter, diameter)), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.scale, image.scale, @"Avatar scale should be equal to original image scale");
}

- (void)testAvatarInitialsImage
{
    CGFloat diameter = 50.0f;
    UIImage *avatar = [JSQMessagesAvatarFactory avatarWithUserInitials:@"JSQ"
                                                       backgroundColor:[UIColor lightGrayColor]
                                                             textColor:[UIColor darkGrayColor]
                                                                  font:[UIFont systemFontOfSize:13.0f]
                                                              diameter:diameter];
    
    XCTAssertNotNil(avatar, @"Avatar should not be nil");
    XCTAssertTrue(CGSizeEqualToSize(avatar.size, CGSizeMake(diameter, diameter)), @"Avatar size should be equal to diameter");
    XCTAssertEqual(avatar.scale, [UIScreen mainScreen].scale, @"Avatar scale should be equal to screen scale");
}

@end
