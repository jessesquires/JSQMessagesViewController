/*
 *  Copyright (c) 2006-2014 Erik Doernenburg and contributors
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

#import "NSInvocation+OCMAdditions.h"
#import "OCMFunctions.h"


@implementation NSInvocation(OCMAdditions)

- (BOOL)hasCharPointerArgument
{
    NSMethodSignature *signature = [self methodSignature];
    for(NSUInteger i = 0; i < [signature numberOfArguments]; i++)
    {
        const char *argType = OCMTypeWithoutQualifiers([signature getArgumentTypeAtIndex:i]);
        if(strcmp(argType, "*") == 0)
            return YES;
    }
    return NO;
}


- (id)getArgumentAtIndexAsObject:(NSInteger)argIndex
{
	const char *argType = OCMTypeWithoutQualifiers([[self methodSignature] getArgumentTypeAtIndex:(NSUInteger)argIndex]);

	if((strlen(argType) > 1) && (strchr("{^", argType[0]) == NULL) && (strcmp("@?", argType) != 0))
		[NSException raise:NSInvalidArgumentException format:@"Cannot handle argument type '%s'.", argType];

    if(OCMIsObjectType(argType))
    {
        id value;
     	[self getArgument:&value atIndex:argIndex];
     	return value;
    }

	switch(argType[0])
	{
		case ':':
 		{
 			SEL s = (SEL)0;
 			[self getArgument:&s atIndex:argIndex];
            return [NSValue valueWithBytes:&s objCType:":"];
 		}
		case 'i': 
		{
			int value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 's':
		{
			short value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'l':
		{
			long value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'q':
		{
			long long value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'c':
		{
			char value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'C':
		{
			unsigned char value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'I':
		{
			unsigned int value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'S':
		{
			unsigned short value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'L':
		{
			unsigned long value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'Q':
		{
			unsigned long long value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'f':
		{
			float value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'd':
		{
			double value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}	
		case 'D':
		{
			long double value;
			[self getArgument:&value atIndex:argIndex];
			return [NSValue valueWithBytes:&value objCType:@encode(__typeof__(value))];
		}
		case 'B':
		{
			bool value;
			[self getArgument:&value atIndex:argIndex];
			return @(value);
		}
		case '^':
        case '*':
        {
            void *value = NULL;
            [self getArgument:&value atIndex:argIndex];
            return [NSValue valueWithPointer:value];
        }
		case '{': // structure
		{
			NSUInteger argSize;
			NSGetSizeAndAlignment([[self methodSignature] getArgumentTypeAtIndex:(NSUInteger)argIndex], &argSize, NULL);
			if(argSize == 0) // TODO: Can this happen? Is frameLength a good choice in that case?
                argSize = [[self methodSignature] frameLength];
			NSMutableData *argumentData = [[[NSMutableData alloc] initWithLength:argSize] autorelease];
			[self getArgument:[argumentData mutableBytes] atIndex:argIndex];
			return [NSValue valueWithBytes:[argumentData bytes] objCType:argType];
		}       
			
	}
	[NSException raise:NSInvalidArgumentException format:@"Argument type '%s' not supported", argType];
	return nil;
}

- (NSString *)invocationDescription
{
	NSMethodSignature *methodSignature = [self methodSignature];
	NSUInteger numberOfArgs = [methodSignature numberOfArguments];
	
	if (numberOfArgs == 2)
		return NSStringFromSelector([self selector]);
	
	NSArray *selectorParts = [NSStringFromSelector([self selector]) componentsSeparatedByString:@":"];
	NSMutableString *description = [[NSMutableString alloc] init];
	NSUInteger i;
	for(i = 2; i < numberOfArgs; i++)
	{
		[description appendFormat:@"%@%@:", (i > 2 ? @" " : @""), [selectorParts objectAtIndex:(i - 2)]];
		[description appendString:[self argumentDescriptionAtIndex:(NSInteger)i]];
	}
	
	return [description autorelease];
}

- (NSString *)argumentDescriptionAtIndex:(NSInteger)argIndex
{
	const char *argType = OCMTypeWithoutQualifiers([[self methodSignature] getArgumentTypeAtIndex:(NSUInteger)argIndex]);

	switch(*argType)
	{
		case '@':	return [self objectDescriptionAtIndex:argIndex];
		case 'B':	return [self boolDescriptionAtIndex:argIndex];
		case 'c':	return [self charDescriptionAtIndex:argIndex];
		case 'C':	return [self unsignedCharDescriptionAtIndex:argIndex];
		case 'i':	return [self intDescriptionAtIndex:argIndex];
		case 'I':	return [self unsignedIntDescriptionAtIndex:argIndex];
		case 's':	return [self shortDescriptionAtIndex:argIndex];
		case 'S':	return [self unsignedShortDescriptionAtIndex:argIndex];
		case 'l':	return [self longDescriptionAtIndex:argIndex];
		case 'L':	return [self unsignedLongDescriptionAtIndex:argIndex];
		case 'q':	return [self longLongDescriptionAtIndex:argIndex];
		case 'Q':	return [self unsignedLongLongDescriptionAtIndex:argIndex];
		case 'd':	return [self doubleDescriptionAtIndex:argIndex];
		case 'f':	return [self floatDescriptionAtIndex:argIndex];
		case 'D':	return [self longDoubleDescriptionAtIndex:argIndex];
		case '{':	return [self structDescriptionAtIndex:argIndex];
		case '^':	return [self pointerDescriptionAtIndex:argIndex];
		case '*':	return [self cStringDescriptionAtIndex:argIndex];
		case ':':	return [self selectorDescriptionAtIndex:argIndex];
		default:	return [@"<??" stringByAppendingString:@">"];  // avoid confusion with trigraphs...
	}
	
}


- (NSString *)objectDescriptionAtIndex:(NSInteger)anInt
{
	id object;
	
	[self getArgument:&object atIndex:anInt];
	if (object == nil)
		return @"nil";
	else if(![object isProxy] && [object isKindOfClass:[NSString class]])
		return [NSString stringWithFormat:@"@\"%@\"", [object description]];
	else
		// The description cannot be nil, if it is then replace it
		return [object description] ?: @"<nil description>";
}

- (NSString *)boolDescriptionAtIndex:(NSInteger)anInt
{
	bool value;
	[self getArgument:&value atIndex:anInt];
	return value? @"YES" : @"NO";
}

- (NSString *)charDescriptionAtIndex:(NSInteger)anInt
{
	unsigned char buffer[128];
	memset(buffer, 0x0, 128);
	
	[self getArgument:&buffer atIndex:anInt];
	
	// If there's only one character in the buffer, and it's 0 or 1, then we have a BOOL
	if (buffer[1] == '\0' && (buffer[0] == 0 || buffer[0] == 1))
		return (buffer[0] == 1 ? @"YES" : @"NO");
	else
		return [NSString stringWithFormat:@"'%c'", *buffer];
}

- (NSString *)unsignedCharDescriptionAtIndex:(NSInteger)anInt
{
	unsigned char buffer[128];
	memset(buffer, 0x0, 128);
	
	[self getArgument:&buffer atIndex:anInt];
	return [NSString stringWithFormat:@"'%c'", *buffer];
}

- (NSString *)intDescriptionAtIndex:(NSInteger)anInt
{
	int intValue;
	
	[self getArgument:&intValue atIndex:anInt];
	return [NSString stringWithFormat:@"%d", intValue];
}

- (NSString *)unsignedIntDescriptionAtIndex:(NSInteger)anInt
{
	unsigned int intValue;
	
	[self getArgument:&intValue atIndex:anInt];
	return [NSString stringWithFormat:@"%d", intValue];
}

- (NSString *)shortDescriptionAtIndex:(NSInteger)anInt
{
	short shortValue;
	
	[self getArgument:&shortValue atIndex:anInt];
	return [NSString stringWithFormat:@"%hi", shortValue];
}

- (NSString *)unsignedShortDescriptionAtIndex:(NSInteger)anInt
{
	unsigned short shortValue;
	
	[self getArgument:&shortValue atIndex:anInt];
	return [NSString stringWithFormat:@"%hu", shortValue];
}

- (NSString *)longDescriptionAtIndex:(NSInteger)anInt
{
	long longValue;
	
	[self getArgument:&longValue atIndex:anInt];
	return [NSString stringWithFormat:@"%ld", longValue];
}

- (NSString *)unsignedLongDescriptionAtIndex:(NSInteger)anInt
{
	unsigned long longValue;
	
	[self getArgument:&longValue atIndex:anInt];
	return [NSString stringWithFormat:@"%lu", longValue];
}

- (NSString *)longLongDescriptionAtIndex:(NSInteger)anInt
{
	long long longLongValue;
	
	[self getArgument:&longLongValue atIndex:anInt];
	return [NSString stringWithFormat:@"%qi", longLongValue];
}

- (NSString *)unsignedLongLongDescriptionAtIndex:(NSInteger)anInt
{
	unsigned long long longLongValue;
	
	[self getArgument:&longLongValue atIndex:anInt];
	return [NSString stringWithFormat:@"%qu", longLongValue];
}

- (NSString *)doubleDescriptionAtIndex:(NSInteger)anInt
{
	double doubleValue;
	
	[self getArgument:&doubleValue atIndex:anInt];
	return [NSString stringWithFormat:@"%f", doubleValue];
}

- (NSString *)floatDescriptionAtIndex:(NSInteger)anInt
{
	float floatValue;
	
	[self getArgument:&floatValue atIndex:anInt];
	return [NSString stringWithFormat:@"%f", floatValue];
}

- (NSString *)longDoubleDescriptionAtIndex:(NSInteger)anInt
{
	long double longDoubleValue;
	
	[self getArgument:&longDoubleValue atIndex:anInt];
	return [NSString stringWithFormat:@"%Lf", longDoubleValue];
}

- (NSString *)structDescriptionAtIndex:(NSInteger)anInt
{
    return [NSString stringWithFormat:@"(%@)", [[self getArgumentAtIndexAsObject:anInt] description]];
}

- (NSString *)pointerDescriptionAtIndex:(NSInteger)anInt
{
	void *buffer;
	
	[self getArgument:&buffer atIndex:anInt];
	return [NSString stringWithFormat:@"%p", buffer];
}

- (NSString *)cStringDescriptionAtIndex:(NSInteger)anInt
{
	char buffer[104];
	char *cStringPtr;
	
	[self getArgument:&cStringPtr atIndex:anInt];
	strncpy(buffer, cStringPtr, 100);
    strcpy(buffer + 100, "...");
	return [NSString stringWithFormat:@"\"%s\"", buffer];
}

- (NSString *)selectorDescriptionAtIndex:(NSInteger)anInt
{
	SEL selectorValue;
	
	[self getArgument:&selectorValue atIndex:anInt];
	return [NSString stringWithFormat:@"@selector(%@)", NSStringFromSelector(selectorValue)];
}

@end
