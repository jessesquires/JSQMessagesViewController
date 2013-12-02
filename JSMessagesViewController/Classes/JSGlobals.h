//
//  JSGlobals.h
//  JSMessagesDemo
//
//  Created by Ahmed Ghalab on 12/1/13.
//  Copyright (c) 2013 Hexed Bits. All rights reserved.
//

#ifndef JSMessagesDemo_JSGlobals_h
#define JSMessagesDemo_JSGlobals_h

/*
 *
 ***************** Feature Flags *****************
 *
 */

/**
 *  Enable the feature of attaching image messages.
 *  @see JSMessageInputView.
 */
#define __FEATURE_FLAGE__IMAGE_BUBBLE_ENABLED YES


/*
 *
 ***************** Predefined Constants *****************
 *
 */

/**
 *  Enable the feature of attaching image messages.
 *  @see JSMessageInputView.
 */
#define IMAGE_BUBBLE_CORNER_SIZE_IN_PIXELS 8.0f


/*
 *
 ***************** Predefined Preprocessors *****************
 *
 */

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#endif
