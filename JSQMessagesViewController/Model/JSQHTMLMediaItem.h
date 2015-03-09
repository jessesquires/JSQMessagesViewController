//
//  JSQHTMLMediaItem.h
//  JSQMessages
//
//  Created by Aaron Jubbal on 3/8/15.
//  Copyright (c) 2015 Hexed Bits. All rights reserved.
//

#import "JSQMediaItem.h"

@interface JSQHTMLMediaItem : JSQMediaItem

@property (copy, nonatomic) UIWebView *webView;
@property (copy, nonatomic) NSString *htmlString;

- (instancetype)initWithHTMLString:(NSString *)htmlString;

@end
