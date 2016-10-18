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
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import <XCTest/XCTest.h>
#import <JSQMessagesViewController/JSQMessagesViewController.h>


@interface JSQMessagesToolbarButtonFactoryTests : XCTestCase

@property (strong, nonatomic) JSQMessagesToolbarButtonFactory *factory;
@property (strong, nonatomic) UIFont *factoryFont;

@end


@implementation JSQMessagesToolbarButtonFactoryTests

- (void)setUp {
    [super setUp];
    self.factoryFont = [UIFont systemFontOfSize:15.0];
    self.factory = [[JSQMessagesToolbarButtonFactory alloc] initWithFont:self.factoryFont];
}

- (void)tearDown {
    [super tearDown];
    self.factoryFont = nil;
    self.factory = nil;
}

- (void)testDefaultSendButtonItem
{
    UIButton *button = [self.factory defaultSendButtonItem];
    XCTAssertNotNil(button, @"Button should not be nil");
    XCTAssertEqual(button.titleLabel.font, self.factoryFont, @"Button should use font provided by factory");
}

- (void)testDefaultAccessoryButtonItem
{
    UIButton *button = [self.factory defaultAccessoryButtonItem];
    XCTAssertNotNil(button, @"Button should not be nil");
    XCTAssertEqual(button.titleLabel.font, self.factoryFont, @"Button should use font provided by factory");
}

@end
