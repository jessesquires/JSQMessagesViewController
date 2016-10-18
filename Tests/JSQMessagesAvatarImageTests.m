//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright © 2014-present Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>
#import <JSQMessagesViewController/JSQMessagesViewController.h>


@interface JSQMessagesAvatarImageTests : XCTestCase

@end


@implementation JSQMessagesAvatarImageTests

- (void)testInitValid
{
    UIImage *mockImage = [UIImage imageNamed:@"image" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    JSQMessagesAvatarImage *avatar = [JSQMessagesAvatarImage avatarImageWithPlaceholder:mockImage];
    XCTAssertNotNil(avatar, @"Valid init should succeed");
    
    JSQMessagesAvatarImage *avatar2 = [JSQMessagesAvatarImage avatarWithImage:mockImage];
    XCTAssertNotNil(avatar2, @"Valid init should succeed");
    
    XCTAssertEqualObjects(avatar2.avatarImage, avatar2.avatarHighlightedImage);
    XCTAssertEqualObjects(avatar2.avatarHighlightedImage, avatar2.avatarPlaceholderImage);
}

- (void)testCopy
{
    UIImage *mockImage = [UIImage imageNamed:@"image" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    JSQMessagesAvatarImage *avatar = [[JSQMessagesAvatarImage alloc] initWithAvatarImage:mockImage
                                                                        highlightedImage:mockImage
                                                                        placeholderImage:mockImage];
    
    JSQMessagesAvatarImage *copy = [avatar copy];
    XCTAssertNotNil(copy, @"Copy should succeed");
    
    XCTAssertFalse(avatar == copy, @"Copy should return new, distinct instance");
    
    XCTAssertNotEqualObjects(avatar.avatarImage, copy.avatarImage, @"Images should not be equal");
    XCTAssertNotEqual(avatar.avatarImage, copy.avatarImage, @"Images should not be equal");
    
    XCTAssertNotEqualObjects(avatar.avatarHighlightedImage, copy.avatarHighlightedImage, @"Images should not be equal");
    XCTAssertNotEqual(avatar.avatarHighlightedImage, copy.avatarHighlightedImage, @"Images should not be equal");
    
    XCTAssertNotEqualObjects(avatar.avatarPlaceholderImage, copy.avatarPlaceholderImage, @"Images should not be equal");
    XCTAssertNotEqual(avatar.avatarPlaceholderImage, copy.avatarPlaceholderImage, @"Images should not be equal");
}

@end
