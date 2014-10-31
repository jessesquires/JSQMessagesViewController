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

#import "JSQMessagesComposerTextView.h"


@interface JSQMessagesComposerTextViewTests : XCTestCase

@property (strong, nonatomic) JSQMessagesComposerTextView *textView;

@end


@implementation JSQMessagesComposerTextViewTests

- (void)setUp
{
    [super setUp];
    
    self.textView = [[JSQMessagesComposerTextView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 50.0f)
                                                         textContainer:[NSTextContainer new]];
}

- (void)tearDown
{
    self.textView = nil;
    
    [super tearDown];
}

- (void)testComposerTextViewInit
{
    XCTAssertNotNil(self.textView, @"Text view should not be nil");
    
    XCTAssertNil(self.textView.text, @"Property should be equal to default value");
    XCTAssertNil(self.textView.placeHolder, @"Property should be equal to default value");
    XCTAssertEqualObjects(self.textView.placeHolderTextColor, [UIColor lightGrayColor], @"Property should be equal to default value");
    
    XCTAssertEqualObjects(self.textView.backgroundColor, [UIColor whiteColor], @"Property should be equal to default value");
    
    XCTAssertEqual(self.textView.layer.borderWidth, 0.5f, @"Property should be equal to default value");
    XCTAssertEqual(self.textView.layer.borderColor, [UIColor lightGrayColor].CGColor, @"Property should be equal to default value");
    XCTAssertEqual(self.textView.layer.cornerRadius, 6.0f, @"Property should be equal to default value");
    
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.textView.scrollIndicatorInsets, UIEdgeInsetsMake(6.0f, 0.0f, 6.0f, 0.0f)), @"Property should be equal to default value");
    
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.textView.textContainerInset, UIEdgeInsetsMake(4.0f, 2.0f, 4.0f, 2.0f)), @"Property should be equal to default value");
    XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.textView.contentInset, UIEdgeInsetsMake(1.0f, 0.0f, 1.0f, 0.0f)), @"Property should be equal to default value");
    
    XCTAssertEqual(self.textView.scrollEnabled, YES, @"Property should be equal to default value");
    XCTAssertEqual(self.textView.scrollsToTop, NO, @"Property should be equal to default value");
    XCTAssertEqual(self.textView.userInteractionEnabled, YES, @"Property should be equal to default value");
    
    XCTAssertEqual(self.textView.contentMode, UIViewContentModeRedraw, @"Property should be equal to default value");
    XCTAssertEqual(self.textView.dataDetectorTypes, UIDataDetectorTypeNone, @"Property should be equal to default value");
    XCTAssertEqual(self.textView.keyboardAppearance, UIKeyboardAppearanceDefault, @"Property should be equal to default value");
    XCTAssertEqual(self.textView.keyboardType, UIKeyboardTypeDefault, @"Property should be equal to default value");
    XCTAssertEqual(self.textView.returnKeyType, UIReturnKeyDefault, @"Property should be equal to default value");
}

@end
