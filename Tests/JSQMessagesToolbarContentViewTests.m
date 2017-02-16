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

@interface JSQMessagesToolbarContentViewTests : XCTestCase

@property (strong, nonatomic) JSQMessagesToolbarContentView *contentView;

@end


@implementation JSQMessagesToolbarContentViewTests

- (void)setUp
{
    [super setUp];
    
    UINib *contentViewNib = [JSQMessagesToolbarContentView nib];
    XCTAssertNotNil(contentViewNib, @"Nib should not be nil");
    
    NSArray *view = [contentViewNib instantiateWithOwner:nil options:nil];
    self.contentView = [view firstObject];
    XCTAssertNotNil(self.contentView, @"Content view should not be nil");
}

- (void)tearDown
{
    self.contentView = nil;
    [super tearDown];
}

- (void)testToolbarContentViewInit
{
    XCTAssertTrue(CGRectEqualToRect(self.contentView.frame, CGRectMake(0.0f, 0.0f, 320.0f, 44.0f)), @"Frame should be equal to default value");
    
    XCTAssertNotNil(self.contentView.textView, @"Text view should not be nil");
    XCTAssertTrue([self.contentView.textView isKindOfClass:[JSQMessagesComposerTextView class]], @"Text view should be a %@", [JSQMessagesComposerTextView class]);
    XCTAssertNil(self.contentView.leftBarButtonItem, @"Property should be equal to default value");
    XCTAssertNil(self.contentView.rightBarButtonItem, @"Property should be equal to default value");
}

@end
