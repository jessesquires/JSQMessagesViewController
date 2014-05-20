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

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.invalidateFlowLayoutDelegateMetrics = NO;
        self.invalidateFlowLayoutAttributes = NO;
    }
    return self;
}

+ (instancetype)defaultContext
{
    JSQMessagesCollectionViewFlowLayoutInvalidationContext *context = [[self alloc] init];
    context.invalidateFlowLayoutDelegateMetrics = YES;
    context.invalidateFlowLayoutAttributes = YES;
    return context;
}
@end
