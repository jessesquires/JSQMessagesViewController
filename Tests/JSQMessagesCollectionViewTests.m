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

@interface JSQMessagesCollectionViewTests : XCTestCase

@end


@implementation JSQMessagesCollectionViewTests

- (void)testCollectionViewInit
{
    JSQMessagesCollectionViewFlowLayout *layout = [[JSQMessagesCollectionViewFlowLayout alloc] init];
    
    JSQMessagesCollectionView *view = [[JSQMessagesCollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                                                  collectionViewLayout:layout];
    
    XCTAssertNotNil(view, @"Collection view should not be nil");
    XCTAssertEqualObjects(view.backgroundColor, [UIColor whiteColor], @"Property should be equal to default value");
    XCTAssertEqual(view.keyboardDismissMode, UIScrollViewKeyboardDismissModeInteractive, @"Property should be equal to default value");
    XCTAssertEqual(view.alwaysBounceVertical, YES, @"Property should be equal to default value");
    XCTAssertEqual(view.bounces, YES, @"Property should be equal to default value");
}

@end
