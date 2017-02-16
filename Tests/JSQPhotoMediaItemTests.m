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
#import <MobileCoreServices/UTCoreTypes.h>

@interface JSQPhotoMediaItemTests : XCTestCase

@end


@implementation JSQPhotoMediaItemTests

- (void)testPhotoItemInit
{
    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage new]];
    XCTAssertNotNil(item);
}

- (void)testPhotoItemIsEqual
{
    UIImage *mockImage = [UIImage imageNamed:@"image" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:mockImage];
    
    JSQPhotoMediaItem *copy = [item copy];
    
    XCTAssertEqualObjects(item, copy, @"Copied items should be equal");
    
    XCTAssertEqual([item hash], [copy hash], @"Copied item hashes should be equal");
    
    XCTAssertEqualObjects(item, item, @"Item should be equal to itself");
}

- (void)testPhotoItemArchiving
{
    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:[UIImage new]];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
    
    JSQPhotoMediaItem *unarchivedItem = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    XCTAssertEqualObjects(item, unarchivedItem);
}

- (void)testMediaDataProtocol
{
    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:nil];
    
    XCTAssertTrue(!CGSizeEqualToSize([item mediaViewDisplaySize], CGSizeZero));
    XCTAssertNotNil([item mediaPlaceholderView]);
    XCTAssertNil([item mediaView], @"Media view should be nil if image is nil");

    UIImage *mockImage = [UIImage imageNamed:@"image" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    item.image = mockImage;

    XCTAssertNotNil([item mediaView], @"Media view should NOT be nil once item has media data");
}

- (void)testCopyableItemInMediaProtocol {
    UIImage *mockImage = [UIImage imageNamed:@"image" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    JSQPhotoMediaItem *item = [[JSQPhotoMediaItem alloc] initWithImage:mockImage];
    XCTAssertNotNil(item);
    XCTAssertEqual([item mediaDataType], (NSString *)kUTTypeJPEG);
    
    UIImage *itemImage = [[UIImage alloc] initWithData:[item mediaData]];
    XCTAssertNotNil(itemImage);
}

@end
