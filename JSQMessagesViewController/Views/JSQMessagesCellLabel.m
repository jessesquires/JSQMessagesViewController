//
// Created by Ivan Vavilov
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

#import <CoreGraphics/CoreGraphics.h>
#import "JSQMessagesCellLabel.h"
#import "NSString+JSQMessages.h"

@implementation JSQMessagesCellLabel

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }

    return self;
}

- (void)initialize
{
    self.textColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark - Setter

- (void)setText:(id)text
{
    [super setText:text];

    if ([text isKindOfClass:[NSAttributedString class]]) {
        //todo find @ and # matches
        [self highlightHashTags];
        [self highlightMentions];
    }
}

-(void) highlightMentions
{
    if (self.text) {
        NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:@"(^| )@[a-z0-9._-]+"
                                                                                      options:NSRegularExpressionCaseInsensitive
                                                                                        error:nil];
        [regularExpression enumerateMatchesInString:self.text
                                            options:NSMatchingReportCompletion
                                              range:NSMakeRange(0, [self.text length])
                                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                             if (result) {
                                                 NSDictionary *attributes = @{(id)kCTForegroundColorAttributeName: [UIColor greenColor], (id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleNone)};
                                                 [self addLinkWithTextCheckingResult:result attributes:attributes];
                                             }
                                         }];
    }
}

-(void) highlightHashTags
{
    if (self.text) {
        NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:@"#\\w+"
                                                                                      options:NSRegularExpressionCaseInsensitive
                                                                                        error:nil];
        [regularExpression enumerateMatchesInString:self.text
                                            options:NSMatchingReportCompletion
                                              range:NSMakeRange(0, [self.text length])
                                         usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                             if (result) {
                                                 NSDictionary *attributes = @{(id)kCTForegroundColorAttributeName: [UIColor greenColor], (id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleNone)};
                                                 [self addLinkWithTextCheckingResult:result attributes:attributes];
                                             }
                                         }];
    }
}



@end