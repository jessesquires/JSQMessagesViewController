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

#import "JSQMessage.h"


@interface JSQMessageTests : XCTestCase

@property (strong, nonatomic) NSString *sender;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSData *audio;
@property (strong, nonatomic) UIImage *sourceImage;
@property (strong, nonatomic) UIImage *thumbnailImage;
@property (strong, nonatomic) UIImage *placeholderImage;
@property (strong, nonatomic) UIImage *videoThumbnail;
@property (strong, nonatomic) UIImage *videoThumbnailPlaceholder;
@property (strong, nonatomic) NSURL *remoteImageURL;
@property (strong, nonatomic) NSURL *localImageURL;
@property (strong, nonatomic) NSURL *remoteVideoURL;
@property (strong, nonatomic) NSURL *localVideoURL;
@property (strong, nonatomic) NSURL *remoteAudioURL;
@property (strong, nonatomic) NSURL *localAudioURL;

@end


@implementation JSQMessageTests

- (void)setUp
{
    [super setUp];
    self.sender = @"Jesse Squires";
    self.date = [NSDate date];
    self.text = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque"
                @"laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi"
                @"architecto beatae vitae dicta sunt explicabo.";
    self.audio = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"demo_for_Elise" ofType:@"mp3"]];
    self.sourceImage = [UIImage imageNamed:@"FICDDemoLargeImage000"];
    self.thumbnailImage = [UIImage imageNamed:@"FICDDemoSmallImage000"];
    self.placeholderImage = [UIImage imageNamed:@"demo_image_placeholder"];
    self.videoThumbnail = [UIImage imageNamed:@"demo_video_thumbnail"];
    self.videoThumbnailPlaceholder = [UIImage imageNamed:@"demo_video_placeholder"];
    self.remoteImageURL = [NSURL URLWithString:@"https://s3.amazonaws.com/fast-image-cache/demo-images/FICDDemoImage000.jpg"];
    self.localImageURL = [[NSBundle mainBundle] URLForResource:@"FICDDemoImage000" withExtension:@"png"];
    self.remoteVideoURL = [NSURL URLWithString:@"https://archive.org/download/AppleAds/Apple-Icloud-TvAd-IcloudHarmony.mp4"];
    self.localVideoURL = [[NSBundle mainBundle] URLForResource:@"demo_video" withExtension:@"mp4"];
    self.remoteAudioURL = [NSURL URLWithString:@"https://ia700304.us.archive.org/9/items/FurElise_656/FurElise_64kb.mp3"];
    self.localAudioURL = [[NSBundle mainBundle] URLForResource:@"demo_for_Elise" withExtension:@"mp3"];
}

- (void)tearDown
{
    self.sender = nil;
    self.date = nil;
    self.text = nil;
    self.sourceImage = nil;
    self.thumbnailImage = nil;
    self.placeholderImage = nil;
    self.videoThumbnail = nil;
    self.videoThumbnailPlaceholder = nil;
    self.audio = nil;
    self.remoteImageURL = nil;
    self.localImageURL = nil;
    self.remoteVideoURL = nil;
    self.localVideoURL = nil;
    self.remoteAudioURL = nil;
    self.localAudioURL = nil;
    
    [super tearDown];
}

- (void)testMessageInit
{
    JSQMessage *msg0 = [[JSQMessage alloc] initWithText:self.text sender:self.sender date:self.date];
    XCTAssertNotNil(msg0, @"Message should not be nil");
    
    JSQMessage *msg1 = [JSQMessage messageWithText:self.text sender:self.sender];
    XCTAssertNotNil(msg1, @"Message shold not be nil");
    
    JSQMessage *msg2 = [[JSQMessage alloc] initWithImageURL:self.remoteImageURL placeholderImage:self.placeholderImage sender:self.sender date:self.date];
    XCTAssertNotNil(msg2, @"Message should not be nil");
    
    JSQMessage *msg3 = [JSQMessage messageWithImageURL:self.remoteImageURL placeholderImage:self.placeholderImage sender:self.sender];
    XCTAssertNotNil(msg3, @"Message should not be nil");
    
    JSQMessage *msg4 = [[JSQMessage alloc] initWithImage:self.sourceImage thumbnailImage:self.thumbnailImage sender:self.sender date:self.date];
    XCTAssertNotNil(msg4, @"Message should not be nil");
    
    JSQMessage *msg5 = [JSQMessage messageWithImage:self.sourceImage thumbnailImage:self.thumbnailImage sender:self.sender];
    XCTAssertNotNil(msg5, @"Message should not be nil");
    
    JSQMessage *msg6 = [[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL thumbnail:self.videoThumbnail sender:self.sender date:self.date];
    XCTAssertNotNil(msg6, @"Message should not be nil");
    
    JSQMessage *msg7 = [JSQMessage messageWithVideoURL:self.remoteVideoURL thumbnail:self.videoThumbnail sender:self.sender];
    XCTAssertNotNil(msg7, @"Message should not be nil");
    
    JSQMessage *msg8 = [[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL placeholderImage:self.placeholderImage sender:self.sender date:self.date];
    XCTAssertNotNil(msg8, @"Message should not be nil");
    
    JSQMessage *msg9 = [JSQMessage messageWithVideoURL:self.remoteVideoURL placeholderImage:self.placeholderImage sender:self.sender];
    XCTAssertNotNil(msg9, @"Message should not be nil");
    
    JSQMessage *msg10 = [[JSQMessage alloc] initWithVideoURL:self.localVideoURL thumbnail:self.videoThumbnail sender:self.sender date:self.date];
    XCTAssertNotNil(msg10, @"Message should not be nil");
    
    JSQMessage *msg11 = [JSQMessage messageWithVideoURL:self.localVideoURL thumbnail:self.videoThumbnail sender:self.sender];
    XCTAssertNotNil(msg11, @"Message should not be nil");
    
    JSQMessage *msg12 = [[JSQMessage alloc] initWithAudio:self.audio sender:self.sender date:self.date];
    XCTAssertNotNil(msg12, @"Message should not be nil");
    
    JSQMessage *msg13 = [JSQMessage messageWithAudio:self.audio sender:self.sender];
    XCTAssertNotNil(msg13, @"Message should not be nil");
    
    JSQMessage *msg14 = [[JSQMessage alloc] initWithAudioURL:self.remoteAudioURL sender:self.sender date:self.date];
    XCTAssertNotNil(msg14, @"Message should not be nil");
    
    JSQMessage *msg15 = [JSQMessage messageWithAudioURL:self.remoteAudioURL sender:self.sender];
    XCTAssertNotNil(msg15, @"Message should not be nil");
    
    JSQMessage *msg16 = [[JSQMessage alloc] initWithAudioURL:self.localAudioURL sender:self.sender date:self.date];
    XCTAssertNotNil(msg16, @"Message should not be nil");
    
    JSQMessage *msg17 = [JSQMessage messageWithAudioURL:self.localAudioURL sender:self.sender];
    XCTAssertNotNil(msg17, @"Message should not be nil");
}

- (void)testTextMessageInvalidInit
{
    XCTAssertThrows([JSQMessage messageWithText:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithText:self.text sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithText:nil sender:self.sender], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithText:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithText:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithText:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithText:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithText:self.text sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithText:self.text sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithText:self.text sender:nil date:self.date], @"Invalid init should throw");
}

- (void)testPhotoMessageInvalidInit
{
    XCTAssertThrows([JSQMessage messageWithImage:nil thumbnailImage:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImage:nil thumbnailImage:self.placeholderImage sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImage:nil thumbnailImage:nil sender:self.sender], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImage:nil thumbnailImage:self.placeholderImage sender:self.sender], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImage:self.sourceImage thumbnailImage:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImage:self.sourceImage thumbnailImage:self.placeholderImage sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImage:self.sourceImage thumbnailImage:nil sender:self.sender], @"Invalid init should throw");
    
    XCTAssertThrows([JSQMessage messageWithImageURL:nil placeholderImage:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImageURL:nil placeholderImage:self.placeholderImage sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImageURL:nil placeholderImage:nil sender:self.sender], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImageURL:nil placeholderImage:self.placeholderImage sender:self.sender], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImageURL:self.remoteImageURL placeholderImage:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImageURL:self.remoteImageURL placeholderImage:self.placeholderImage sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImageURL:self.remoteImageURL placeholderImage:nil sender:self.sender], @"Invalid init should throw");
    
    XCTAssertThrows([JSQMessage messageWithImageURL:self.localImageURL placeholderImage:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImageURL:self.localImageURL placeholderImage:self.placeholderImage sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithImageURL:self.localImageURL placeholderImage:nil sender:self.sender], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithImage:nil thumbnailImage:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:nil thumbnailImage:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:nil thumbnailImage:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:nil thumbnailImage:self.thumbnailImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithImage:nil thumbnailImage:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:nil thumbnailImage:self.thumbnailImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:nil thumbnailImage:self.thumbnailImage sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:nil thumbnailImage:self.thumbnailImage sender:self.sender date:self.date], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithImage:self.sourceImage thumbnailImage:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:self.sourceImage thumbnailImage:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:self.sourceImage thumbnailImage:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:self.sourceImage thumbnailImage:self.thumbnailImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithImage:self.sourceImage thumbnailImage:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:self.sourceImage thumbnailImage:self.thumbnailImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImage:self.sourceImage thumbnailImage:self.thumbnailImage sender:self.sender date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:nil placeholderImage:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:nil placeholderImage:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:nil placeholderImage:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:nil placeholderImage:self.placeholderImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:nil placeholderImage:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:nil placeholderImage:self.placeholderImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:nil placeholderImage:self.placeholderImage sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:nil placeholderImage:self.placeholderImage sender:self.sender date:self.date], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.remoteImageURL placeholderImage:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.remoteImageURL placeholderImage:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.remoteImageURL placeholderImage:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.remoteImageURL placeholderImage:self.placeholderImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.remoteImageURL placeholderImage:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.remoteImageURL placeholderImage:self.placeholderImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.remoteImageURL placeholderImage:self.placeholderImage sender:self.sender date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.localImageURL placeholderImage:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.localImageURL placeholderImage:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.localImageURL placeholderImage:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.localImageURL placeholderImage:self.placeholderImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.localImageURL placeholderImage:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.localImageURL placeholderImage:self.placeholderImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithImageURL:self.localImageURL placeholderImage:self.placeholderImage sender:self.sender date:nil], @"Invalid init should throw");
}

- (void)testVideoMessageInvalidInit
{
    XCTAssertThrows([JSQMessage messageWithVideoURL:nil thumbnail:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:nil thumbnail:self.videoThumbnailPlaceholder sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:nil thumbnail:nil sender:self.sender], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:nil thumbnail:self.videoThumbnailPlaceholder sender:self.sender], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.remoteVideoURL thumbnail:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.remoteVideoURL thumbnail:self.videoThumbnailPlaceholder sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.remoteVideoURL thumbnail:nil sender:self.sender], @"Invalid init should throw");
    
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.localVideoURL thumbnail:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.localVideoURL thumbnail:self.videoThumbnailPlaceholder sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.localVideoURL thumbnail:nil sender:self.sender], @"Invalid init should throw");
    
    XCTAssertThrows([JSQMessage messageWithVideoURL:nil placeholderImage:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:nil placeholderImage:self.videoThumbnailPlaceholder sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:nil placeholderImage:nil sender:self.sender], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:nil placeholderImage:self.videoThumbnailPlaceholder sender:self.sender], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.remoteVideoURL placeholderImage:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.remoteVideoURL placeholderImage:self.videoThumbnailPlaceholder sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.remoteVideoURL placeholderImage:nil sender:self.sender], @"Invalid init should throw");
    
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.localVideoURL placeholderImage:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.localVideoURL placeholderImage:self.videoThumbnailPlaceholder sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithVideoURL:self.localVideoURL placeholderImage:nil sender:self.sender], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil thumbnail:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil thumbnail:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil thumbnail:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil thumbnail:self.placeholderImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil thumbnail:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil thumbnail:self.placeholderImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil thumbnail:self.placeholderImage sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil thumbnail:self.placeholderImage sender:self.sender date:self.date], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL thumbnail:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL thumbnail:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL thumbnail:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL thumbnail:self.placeholderImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL thumbnail:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL thumbnail:self.placeholderImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL thumbnail:self.placeholderImage sender:self.sender date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL thumbnail:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL thumbnail:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL thumbnail:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL thumbnail:self.placeholderImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL thumbnail:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL thumbnail:self.placeholderImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL thumbnail:self.placeholderImage sender:self.sender date:nil], @"Invalid init should throw");
    
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil placeholderImage:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil placeholderImage:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil placeholderImage:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil placeholderImage:self.placeholderImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil placeholderImage:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil placeholderImage:self.placeholderImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil placeholderImage:self.placeholderImage sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:nil placeholderImage:self.placeholderImage sender:self.sender date:self.date], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL placeholderImage:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL placeholderImage:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL placeholderImage:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL placeholderImage:self.placeholderImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL placeholderImage:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL placeholderImage:self.placeholderImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.remoteVideoURL placeholderImage:self.placeholderImage sender:self.sender date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL placeholderImage:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL placeholderImage:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL placeholderImage:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL placeholderImage:self.placeholderImage sender:nil date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL placeholderImage:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL placeholderImage:self.placeholderImage sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithVideoURL:self.localVideoURL placeholderImage:self.placeholderImage sender:self.sender date:nil], @"Invalid init should throw");
}


- (void)testAudioMessageInvalidInit
{
    XCTAssertThrows([JSQMessage messageWithAudio:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithAudio:self.audio sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithAudio:nil sender:self.sender], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithAudioURL:nil sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithAudioURL:self.remoteAudioURL sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithAudioURL:self.localAudioURL sender:nil], @"Invalid init should throw");
    XCTAssertThrows([JSQMessage messageWithAudioURL:nil sender:self.sender], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithAudio:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudio:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudio:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudio:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudio:self.audio sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudio:self.audio sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudio:self.audio sender:self.sender date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithAudioURL:nil sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudioURL:nil sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudioURL:nil sender:self.sender date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudioURL:nil sender:self.sender date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudioURL:self.remoteAudioURL sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudioURL:self.remoteAudioURL sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudioURL:self.remoteAudioURL sender:self.sender date:nil], @"Invalid init should throw");
    
    XCTAssertThrows([[JSQMessage alloc] initWithAudioURL:self.localAudioURL sender:nil date:nil], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudioURL:self.localAudioURL sender:nil date:self.date], @"Invalid init should throw");
    XCTAssertThrows([[JSQMessage alloc] initWithAudioURL:self.localAudioURL sender:self.sender date:nil], @"Invalid init should throw");
}

- (void)testTextMessageIsEqual
{
    JSQMessage *msg = [JSQMessage messageWithText:self.text sender:self.sender];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertTrue([msg isEqualToMessage:copy], @"Copied messages should be equal");
    XCTAssertTrue([msg isEqualToMessage:msg], @"Messages should be equal to itself");
    XCTAssertFalse([msg isEqualToMessage:nil], @"Initialized message should not be equal to nil");
}

- (void)testPhotoMessageIsEqual
{
    JSQMessage *msg = [JSQMessage messageWithImage:self.sourceImage thumbnailImage:self.thumbnailImage sender:self.sender];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertTrue([msg isEqualToMessage:copy], @"Copied messages should be equal");
    XCTAssertTrue([msg isEqualToMessage:msg], @"Messages should be equal to itself");
    XCTAssertFalse([msg isEqualToMessage:nil], @"Initialized message should not be equal to nil");
}

- (void)testRemotePhotoMessageIsEqual
{
    JSQMessage *msg = [JSQMessage messageWithImageURL:self.remoteImageURL placeholderImage:self.placeholderImage sender:self.sender];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertTrue([msg isEqualToMessage:copy], @"Copied messages should be equal");
    XCTAssertTrue([msg isEqualToMessage:msg], @"Messages should be equal to itself");
    XCTAssertFalse([msg isEqualToMessage:nil], @"Initialized message should not be equal to nil");
}

- (void)testRemoteVideoMessageIsEqual
{
    JSQMessage *msg = [JSQMessage messageWithVideoURL:self.remoteVideoURL thumbnail:self.videoThumbnail sender:self.sender];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertTrue([msg isEqualToMessage:copy], @"Copied messages should be equal");
    XCTAssertTrue([msg isEqualToMessage:msg], @"Messages should be equal to itself");
    XCTAssertFalse([msg isEqualToMessage:nil], @"Initialized message should not be equal to nil");
}

- (void)testLocalVideoMessageIsEqual
{
    JSQMessage *msg = [JSQMessage messageWithVideoURL:self.localVideoURL thumbnail:self.videoThumbnail sender:self.sender];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertTrue([msg isEqualToMessage:copy], @"Copied messages should be equal");
    XCTAssertTrue([msg isEqualToMessage:msg], @"Messages should be equal to itself");
    XCTAssertFalse([msg isEqualToMessage:nil], @"Initialized message should not be equal to nil");
}

- (void)testRemoteThumbnailVideoMessageIsEqual
{
    JSQMessage *msg = [JSQMessage messageWithVideoURL:self.remoteVideoURL placeholderImage:self.videoThumbnailPlaceholder sender:self.sender];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertTrue([msg isEqualToMessage:copy], @"Copied messages should be equal");
    XCTAssertTrue([msg isEqualToMessage:msg], @"Messages should be equal to itself");
    XCTAssertFalse([msg isEqualToMessage:nil], @"Initialized message should not be equal to nil");
}

- (void)testAudioMessageIsEqual
{
    JSQMessage *msg = [JSQMessage messageWithAudio:self.audio sender:self.sender];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertTrue([msg isEqualToMessage:copy], @"Copied messages should be equal");
    XCTAssertTrue([msg isEqualToMessage:msg], @"Messages should be equal to itself");
    XCTAssertFalse([msg isEqualToMessage:nil], @"Initialized message should not be equal to nil");
}

- (void)testRemoteAudioMessageIsEqual
{
    JSQMessage *msg = [JSQMessage messageWithAudioURL:self.remoteAudioURL sender:self.sender];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertTrue([msg isEqualToMessage:copy], @"Copied messages should be equal");
    XCTAssertTrue([msg isEqualToMessage:msg], @"Messages should be equal to itself");
    XCTAssertFalse([msg isEqualToMessage:nil], @"Initialized message should not be equal to nil");
}

- (void)testLocalAudioMessageIsEqual
{
    JSQMessage *msg = [JSQMessage messageWithAudioURL:self.localAudioURL sender:self.sender];
    JSQMessage *copy = [msg copy];
    
    XCTAssertEqualObjects(msg, copy, @"Copied messages should be equal");
    XCTAssertEqual([msg hash], [copy hash], @"Copied messages hashes should be equal");
    
    XCTAssertTrue([msg isEqualToMessage:copy], @"Copied messages should be equal");
    XCTAssertTrue([msg isEqualToMessage:msg], @"Messages should be equal to itself");
    XCTAssertFalse([msg isEqualToMessage:nil], @"Initialized message should not be equal to nil");
}


- (void)testTextMessageArchiving
{
    JSQMessage *msg = [JSQMessage messageWithText:self.text sender:self.sender];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertTrue([msg isEqualToMessage:unarchivedMsg], @"Message should be equal");
}

- (void)testPhotoMessageArchiving
{
    JSQMessage *msg = [JSQMessage messageWithImage:self.sourceImage thumbnailImage:self.thumbnailImage sender:self.sender];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertTrue([msg isEqualToMessage:unarchivedMsg], @"Message should be equal");
}

- (void)testRemotePhotoMessageArchiving
{
    JSQMessage *msg = [JSQMessage messageWithImageURL:self.remoteImageURL placeholderImage:self.placeholderImage sender:self.sender];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertTrue([msg isEqualToMessage:unarchivedMsg], @"Message should be equal");
}


- (void)testRemoteVideoMessageArchiving
{
    JSQMessage *msg = [JSQMessage messageWithVideoURL:self.remoteVideoURL thumbnail:self.videoThumbnail sender:self.sender];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertTrue([msg isEqualToMessage:unarchivedMsg], @"Message should be equal");
}

- (void)testLocalVideoMessageArchiving
{
    JSQMessage *msg = [JSQMessage messageWithVideoURL:self.localVideoURL thumbnail:self.videoThumbnail sender:self.sender];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertTrue([msg isEqualToMessage:unarchivedMsg], @"Message should be equal");
}

- (void)testRemoteThumbnailVideoMessageArchiving
{
    JSQMessage *msg = [JSQMessage messageWithVideoURL:self.remoteVideoURL placeholderImage:self.videoThumbnailPlaceholder sender:self.sender];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertTrue([msg isEqualToMessage:unarchivedMsg], @"Message should be equal");
}

- (void)testAudioMessageArchiving
{
    JSQMessage *msg = [JSQMessage messageWithAudio:self.audio sender:self.sender];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertTrue([msg isEqualToMessage:unarchivedMsg], @"Message should be equal");
}

- (void)testLocalAudioMessageArchiving
{
    JSQMessage *msg = [JSQMessage messageWithAudioURL:self.localAudioURL sender:self.sender];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertTrue([msg isEqualToMessage:unarchivedMsg], @"Message should be equal");
}

- (void)testRemoteAudioMessageArchiving
{
    JSQMessage *msg = [JSQMessage messageWithAudioURL:self.remoteAudioURL sender:self.sender];
    NSData *msgData = [NSKeyedArchiver archivedDataWithRootObject:msg];
    
    JSQMessage *unarchivedMsg = [NSKeyedUnarchiver unarchiveObjectWithData:msgData];
    
    XCTAssertTrue([msg isEqualToMessage:unarchivedMsg], @"Message should be equal");
}

@end
