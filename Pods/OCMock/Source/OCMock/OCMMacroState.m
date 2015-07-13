/*
 *  Copyright (c) 2014 Erik Doernenburg and contributors
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

#import "OCMMacroState.h"
#import "OCMStubRecorder.h"
#import "OCMockObject.h"
#import "OCMExpectationRecorder.h"
#import "OCMVerifier.h"
#import "OCMInvocationMatcher.h"


@implementation OCMMacroState

OCMMacroState *globalState;

#pragma mark  Methods to begin/end macros

+ (void)beginStubMacro
{
    OCMStubRecorder *recorder = [[[OCMStubRecorder alloc] init] autorelease];
    globalState = [[[OCMMacroState alloc] initWithRecorder:recorder] autorelease];
}

+ (OCMStubRecorder *)endStubMacro
{
    OCMStubRecorder *recorder = (OCMStubRecorder *)[globalState recorder];
    globalState = nil;
    return recorder;
}


+ (void)beginExpectMacro
{
    OCMExpectationRecorder *recorder = [[[OCMExpectationRecorder alloc] init] autorelease];
    globalState = [[[OCMMacroState alloc] initWithRecorder:recorder] autorelease];
}

+ (OCMStubRecorder *)endExpectMacro
{
    return [self endStubMacro];
}


+ (void)beginVerifyMacroAtLocation:(OCMLocation *)aLocation
{
    OCMVerifier *recorder = [[[OCMVerifier alloc] init] autorelease];
    [recorder setLocation:aLocation];
    globalState = [[[OCMMacroState alloc] initWithRecorder:recorder] autorelease];
}

+ (void)endVerifyMacro
{
    globalState = nil;
}


#pragma mark  Accessing global state

+ (OCMMacroState *)globalState
{
    return globalState;
}


#pragma mark  Init, dealloc, accessors

- (id)initWithRecorder:(OCMRecorder *)aRecorder
{
    self = [super init];
    recorder = [aRecorder retain];
    return self;
}

- (void)dealloc
{
    [recorder release];
    if(globalState == self)
        globalState = nil;
    [super dealloc];
}

- (OCMRecorder *)recorder
{
    return recorder;
}


#pragma mark  Changing the recorder

- (void)switchToClassMethod
{
    [recorder classMethod];
}


@end
