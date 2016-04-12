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
#import "JSQHTMLMessageView.h"

@interface JSQHTMLMessageViewTests : XCTestCase <JSQCustomMediaViewDelegate>
@property (nonatomic, strong) XCTestExpectation *fetchExpectation;
@end

@implementation JSQHTMLMessageViewTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testHTMLMessageViewInit
{
    JSQHTMLMessageView *view = [[JSQHTMLMessageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    XCTAssertNotNil(view, @"HTML view should not be nil");


    JSQMessage *message = [view generateMessageWithSenderId:@"1" displayName:@"Foo"];
    XCTAssertNotNil(message, @"Generated message should not be nil");
}

- (void)testHTMLMessageViewLoad
{
    self.fetchExpectation = [self expectationWithDescription:@"Render HTML"];

    JSQHTMLMessageView *view = [[JSQHTMLMessageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    XCTAssertNotNil(view, @"HTML view should not be nil");

    view.delegate = self;

    [view.webView loadHTMLString:@"<html><body><div>SOME HTML</div></body></html>" baseURL:nil];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        if (error) {
            NSLog(@"Timeout Error: %@", error);
        }
    }];
}

- (void)customMediaView:(JSQCustomMediaView *)mediaView contentSizeChanged:(CGSize)newSize {
    XCTAssertTrue(newSize.height > 0 && newSize.width > 0, @"Rendered content size should not be zero");
    [self.fetchExpectation fulfill];
}

@end
