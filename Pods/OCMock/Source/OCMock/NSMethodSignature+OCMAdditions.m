/*
 *  Copyright (c) 2009-2014 Erik Doernenburg and contributors
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

#import "NSMethodSignature+OCMAdditions.h"
#import "OCMFunctions.h"
#import <objc/runtime.h>


@implementation NSMethodSignature(OCMAdditions)

- (BOOL)usesSpecialStructureReturn
{
    const char *types = OCMTypeWithoutQualifiers([self methodReturnType]);

    if((types == NULL) || (types[0] != '{'))
        return NO;

    /* In some cases structures are returned by ref. The rules are complex and depend on the
       architecture, see:

       http://sealiesoftware.com/blog/archive/2008/10/30/objc_explain_objc_msgSend_stret.html
       http://developer.apple.com/library/mac/#documentation/DeveloperTools/Conceptual/LowLevelABI/000-Introduction/introduction.html
       https://github.com/atgreen/libffi/blob/master/src/x86/ffi64.c
       http://www.uclibc.org/docs/psABI-x86_64.pdf
       http://infocenter.arm.com/help/topic/com.arm.doc.ihi0042e/IHI0042E_aapcs.pdf

       NSMethodSignature knows the details but has no API to return it, though it is in
       the debugDescription. Horribly kludgy.
    */
    NSRange range = [[self debugDescription] rangeOfString:@"is special struct return? YES"];
    return range.length > 0;
}

- (NSString *)fullTypeString
{
    NSMutableString *typeString = [NSMutableString string];
    [typeString appendFormat:@"%s", [self methodReturnType]];
    for (NSUInteger i=0; i<[self numberOfArguments]; i++)
        [typeString appendFormat:@"%s", [self getArgumentTypeAtIndex:i]];
    return typeString;
}

- (const char *)fullObjCTypes
{
    return [[self fullTypeString] UTF8String];
}

@end
