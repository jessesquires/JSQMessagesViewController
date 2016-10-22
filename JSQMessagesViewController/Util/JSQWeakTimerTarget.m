//
//  JSQWeakTimerTarget.m
//  JSQMessages
//
//  Created by Alexei Gridnev on 10/23/16.
//  Based on: http://stackoverflow.com/a/16822471

#import "JSQWeakTimerTarget.h"

@implementation JSQWeakTimerTarget
{
    __weak id timerTarget;
    SEL timerSelector;
}

- (instancetype)initWithTarget:(id)target selector:(SEL)selector {
    if (self = [super init]) {
        timerTarget = target;
        timerSelector = selector;
    }
    return self;
}

- (void)timerDidFire:(NSTimer *)timer
{
    if (timerTarget) {
        // see: http://stackoverflow.com/a/20058585
        IMP imp = [timerTarget methodForSelector:timerSelector];
        void (*func)(id, SEL, id) = (void *)imp;
        func(timerTarget, timerSelector, timer);
    } else {
        [timer invalidate];
    }
}
@end
