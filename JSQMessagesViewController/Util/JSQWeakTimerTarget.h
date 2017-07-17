//
//  JSQWeakTimerTarget.h
//  JSQMessages
//
//  Created by Alexei Gridnev on 10/23/16.
//

#import <Foundation/Foundation.h>

@interface JSQWeakTimerTarget : NSObject

- (instancetype)initWithTarget:(id)target selector:(SEL)selector;
    
@end
