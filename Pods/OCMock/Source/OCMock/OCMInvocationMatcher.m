/*
 *  Copyright (c) 2014-2015 Erik Doernenburg and contributors
 *
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may
 *  not use these files except in compliance with the License. You may obtain
 *  a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 *  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
 *  License for the specific language governing permissions and limitations
 *  under the License.
 */

#import <objc/runtime.h>
#import <OCMock/OCMArg.h>
#import <OCMock/OCMConstraint.h>
#import "OCMPassByRefSetter.h"
#import "NSInvocation+OCMAdditions.h"
#import "OCMInvocationMatcher.h"
#import "OCClassMockObject.h"
#import "OCMFunctions.h"


@interface NSObject(HCMatcherDummy)
- (BOOL)matches:(id)item;
@end


@implementation OCMInvocationMatcher

- (void)dealloc
{
    [recordedInvocation release];
    [super dealloc];
}

- (void)setInvocation:(NSInvocation *)anInvocation
{
    [recordedInvocation release];
    // When the method has a char* argument we do not retain the arguments. This makes it possible
    // to match char* args literally and with anyPointer. Not retaining the argument means that
    // in these cases tests that use their own autorelease pools may fail unexpectedly.
    if(![anInvocation hasCharPointerArgument])
        [anInvocation retainArguments];
    recordedInvocation = [anInvocation retain];
}

- (void)setRecordedAsClassMethod:(BOOL)flag
{
    recordedAsClassMethod = flag;
}

- (BOOL)recordedAsClassMethod
{
    return recordedAsClassMethod;
}

- (void)setIgnoreNonObjectArgs:(BOOL)flag
{
    ignoreNonObjectArgs = flag;
}

- (NSString *)description
{
    return [recordedInvocation invocationDescription];
}

- (NSInvocation *)recordedInvocation
{
    return recordedInvocation;
}

- (BOOL)matchesSelector:(SEL)sel
{
    if(sel == [recordedInvocation selector])
        return YES;
    if(OCMIsAliasSelector(sel) &&
       OCMOriginalSelectorForAlias(sel) == [recordedInvocation selector])
        return YES;

    return NO;
}

- (BOOL)matchesInvocation:(NSInvocation *)anInvocation
{
    id target = [anInvocation target];
    BOOL isClassMethodInvocation = (target != nil) && (target == [target class]);
    if(isClassMethodInvocation != recordedAsClassMethod)
        return NO;

    if(![self matchesSelector:[anInvocation selector]])
        return NO;

    NSMethodSignature *signature = [recordedInvocation methodSignature];
    NSUInteger n = [signature numberOfArguments];
    for(NSUInteger i = 2; i < n; i++)
    {
        if(ignoreNonObjectArgs && strcmp([signature getArgumentTypeAtIndex:i], @encode(id)))
        {
            continue;
        }

        id recordedArg = [recordedInvocation getArgumentAtIndexAsObject:i];
        id passedArg = [anInvocation getArgumentAtIndexAsObject:i];

        if([recordedArg isProxy])
        {
            if(![recordedArg isEqual:passedArg])
                return NO;
            continue;
        }

        if([recordedArg isKindOfClass:[NSValue class]])
            recordedArg = [OCMArg resolveSpecialValues:recordedArg];

        if([recordedArg isKindOfClass:[OCMConstraint class]])
        {
            if([recordedArg evaluate:passedArg] == NO)
                return NO;
        }
        else if([recordedArg isKindOfClass:[OCMPassByRefSetter class]])
        {
            id valueToSet = [(OCMPassByRefSetter *)recordedArg value];
            // side effect but easier to do here than in handleInvocation
            if(![valueToSet isKindOfClass:[NSValue class]])
                *(id *)[passedArg pointerValue] = valueToSet;
            else
                [(NSValue *)valueToSet getValue:[passedArg pointerValue]];
        }
        else if([recordedArg conformsToProtocol:objc_getProtocol("HCMatcher")])
        {
            if([recordedArg matches:passedArg] == NO)
                return NO;
        }
        else
        {
            if(([recordedArg class] == [NSNumber class]) &&
                    ([(NSNumber*)recordedArg compare:(NSNumber*)passedArg] != NSOrderedSame))
                return NO;
            if(([recordedArg isEqual:passedArg] == NO) &&
                    !((recordedArg == nil) && (passedArg == nil)))
                return NO;
        }
    }
    return YES;
}

@end
