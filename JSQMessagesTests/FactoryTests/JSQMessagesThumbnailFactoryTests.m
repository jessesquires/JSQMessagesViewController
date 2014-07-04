//
//  JSQMessagesThumbnailFactoryTests.m
//  JSQMessages
//
//  Created by Vincent Sit on 14-7-3.
//  Copyright (c) 2014年 Hexed Bits. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "JSQMessagesThumbnailFactory.h"

@interface JSQMessagesThumbnailFactoryTests : XCTestCase

@end

@implementation JSQMessagesThumbnailFactoryTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThumbnail
{
    NSURL *remoteVideoURL = [NSURL URLWithString:@"https://archive.org/download/AppleAds/Apple-Icloud-TvAd-IcloudHarmony.mp4"];
    XCTAssertNotNil(remoteVideoURL, @"Remote video url should not be nil");
    
    UIImage *remoteVideoThumbnail = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:remoteVideoURL];
    XCTAssertNotNil(remoteVideoThumbnail, @"Remote thumbnail should not be nil");
    
    NSURL *localVideoURL = [[NSBundle mainBundle] URLForResource:@"demo_video" withExtension:@"mp4"];
    XCTAssertNotNil(localVideoURL, @"Local video url should not be nil");
    
    UIImage *localVideoThumbnail = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:localVideoURL];
    XCTAssertNotNil(localVideoThumbnail, @"Local video thumbnail shou not be nil");
}

/**
 *  These tests may fail. Because of various reasons, access to remote video thumbnails may fail.
 */
- (void)testThumbnailSpecifiedTime
{
    NSURL *remoteVideoURL = [NSURL URLWithString:@"https://archive.org/download/AppleAds/Apple-Icloud-TvAd-IcloudHarmony.mp4"];
    XCTAssertNotNil(remoteVideoURL, @"Remote video url should not be nil");
    
    UIImage *remoteVideoThumbnailAtSecond = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:remoteVideoURL atSeconds:1];
    XCTAssertNotNil(remoteVideoThumbnailAtSecond, @"Remote video thumbnail at 1 second should not be nil");
    
    UIImage *remoteVideoThumbnailAtMoreLongSecond = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:remoteVideoURL atSeconds:5];
    XCTAssertNotNil(remoteVideoThumbnailAtMoreLongSecond, @"Remote video thumnail at more long second should not be nil");
    
    UIImage *remoteVideoThumbnailAtTooLongSecond = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:remoteVideoURL atSeconds:100000];
    XCTAssertNil(remoteVideoThumbnailAtTooLongSecond, @"Remote video thumbnail at too long second should be nil");
    
    UIImage *remoteVideoThumbnail = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:remoteVideoURL atTime:CMTimeMake(25, 25)];
    XCTAssertNotNil(remoteVideoThumbnail, @"Remote video thumbnail should not be nil");
    
//    UIImage *remoteVideoThumbnailWithTooLargeTime = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:remoteVideoURL atTime:CMTimeMake(25 * 60 * 9, 25)];
//    XCTAssertNil(remoteVideoThumbnailWithTooLargeTime, @"Remote thumbnail with too large time should be nil");
    
    /**
     *  Our local video frame rate is 24 frames per second.
     */
    NSURL *localVideoURL = [[NSBundle mainBundle] URLForResource:@"demo_video" withExtension:@"mp4"];
    XCTAssertNotNil(localVideoURL, @"Local video url should not be nil");
    
    UIImage *localVideoThumbnailAtSecond = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:localVideoURL atSeconds:1];
    XCTAssertNotNil(localVideoThumbnailAtSecond, @"Local video thumbnail at 1 second should not be nil");
    
    UIImage *localVideoThumbnailAtMoreLongSecond = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:localVideoURL atSeconds:5];
    XCTAssertNotNil(localVideoThumbnailAtMoreLongSecond, @"Local video thumbnail at more long second should not be nil");
    
    UIImage *localVideoThumbnailAtTooLongSecond = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:localVideoURL atSeconds:60];
    XCTAssertNil(localVideoThumbnailAtTooLongSecond, @"Local video thumbnail at too long second should be nil");
    
    UIImage *localVideoThumbnail = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:localVideoURL atTime:CMTimeMake(24, 24)];
    XCTAssertNotNil(localVideoThumbnail, @"Local video thumbnail shou not be nil");
    
//    UIImage *localVideoThumbnailWithTooLargeTime = [JSQMessagesThumbnailFactory thumbnailFromVideoURL:localVideoURL atTime:CMTimeMake(24 * 60 * 55, 24)];
//    XCTAssertNil(localVideoThumbnailWithTooLargeTime, @"Local video thumbnail with too large time should be nil");
    
}



@end
