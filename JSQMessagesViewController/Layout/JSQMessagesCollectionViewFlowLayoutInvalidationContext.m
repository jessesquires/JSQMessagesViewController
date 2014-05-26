//
//  Created by Jesse Squires
//  http://www.hexedbits.com
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

#import "JSQMessagesCollectionViewFlowLayoutInvalidationContext.h"

@implementation JSQMessagesCollectionViewFlowLayoutInvalidationContext

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.invalidateFlowLayoutDelegateMetrics = NO;
        self.invalidateFlowLayoutAttributes = NO;
    }
    return self;
}

+ (instancetype)context
{
    JSQMessagesCollectionViewFlowLayoutInvalidationContext *context = [[JSQMessagesCollectionViewFlowLayoutInvalidationContext alloc] init];
    context.invalidateFlowLayoutDelegateMetrics = YES;
    context.invalidateFlowLayoutAttributes = YES;
    return context;
}

#pragma mark - NSObject

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: invalidateFlowLayoutDelegateMetrics=%d, invalidateFlowLayoutAttributes=%d, invalidateDataSourceCounts=%d>",
            [self class],
            self.invalidateFlowLayoutDelegateMetrics,
            self.invalidateFlowLayoutAttributes,
            self.invalidateDataSourceCounts];
}

@end
