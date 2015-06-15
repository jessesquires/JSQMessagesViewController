//
//  CAIExpressionParser.m
//  CAIExpressionDemo
//
//  Created by liyufeng on 15/5/8.
//  Copyright (c) 2015年 liyufeng. All rights reserved.
//

#import "CAIExpressionParser.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CAIExpressionParser ()

@end

@implementation CAIExpressionParser

#pragma mark - C language

void RunDelegateDeallocCallback( void* refCon ){
}

CGFloat RunDelegateGetAscentCallback( void *refCon ){
    NSMutableAttributedString * attributedString = (__bridge NSMutableAttributedString *)refCon;
    NSDictionary * dic = [attributedString attributesAtIndex:0 effectiveRange:NULL];
    UIFont * font = dic[NSFontAttributeName];
    CGFloat fontSize = [UIFont systemFontSize];
    if (font) {
        fontSize = font.pointSize;
    }
    return fontSize;
}

CGFloat RunDelegateGetDescentCallback(void *refCon){
    NSMutableAttributedString * attributedString = (__bridge NSMutableAttributedString *)refCon;
    NSDictionary * dic = [attributedString attributesAtIndex:0 effectiveRange:NULL];
    UIFont * font = dic[NSFontAttributeName];
    CGFloat fontSize = [UIFont systemFontSize];
    if (font) {
        fontSize = font.pointSize;
    }
    return fontSize*0;
}

CGFloat RunDelegateGetWidthCallback(void *refCon){
    NSMutableAttributedString * attributedString = (__bridge NSMutableAttributedString *)refCon;
    NSDictionary * dic = [attributedString attributesAtIndex:0 effectiveRange:NULL];
    UIFont * font = dic[NSFontAttributeName];
    CGFloat fontSize = [UIFont systemFontSize];
    if (font) {
        fontSize = font.pointSize;
    }
    return fontSize*1.2;
}

#pragma mark - OC

+ (CAIExpressionParser *)shareParser{
    static CAIExpressionParser * share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[CAIExpressionParser alloc]init];
    });
    return share;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSMutableArray * names = [NSMutableArray array];
        NSMutableDictionary *files = [NSMutableDictionary dictionary];
        NSString * filePath = [[NSBundle mainBundle]pathForResource:@"expressions" ofType:@"plist"];
        NSDictionary * dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSDictionary * buttonIconDic = dic[@"keyBoardDelegateIcon"];
        NSArray * arr = dic[@"expressions"];
        for (NSInteger i=0; i<arr.count ;i++) {
            NSDictionary * dic = arr[i];
            NSString * expressName = dic[@"name"];
            NSString * expressFile = dic[@"image"];
            
            [names addObject:expressName];
            [files setObject:expressFile forKey:expressName];
        }
        self.expressionNames = [NSArray arrayWithArray:names];
        self.expressionFile = [NSDictionary dictionaryWithDictionary:files];
        self.keyBoardDeleteIcon = buttonIconDic[@"normal"];
        self.keyboardDeleteIconHL = buttonIconDic[@"heightLight"];
    }
    return self;
}

+ (NSMutableAttributedString *)attributedString:(NSString *)string
{
    NSError * error = nil;
    NSString *regTags = @"\\[[\\w]*\\]";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, [string length])];
    NSMutableAttributedString * atString = [[NSMutableAttributedString alloc]init];
    
    NSInteger index = 0;
    if (matches.count) {//如果有
        for (NSInteger i=0; i<matches.count; i++) {
            NSTextCheckingResult * match = matches[i];
            if (index <match.range.location) {//加载中间的文字
                [atString appendAttributedString:[[NSAttributedString alloc]initWithString:[string substringWithRange:NSMakeRange(index, match.range.location-index)]]];
                index = match.range.location;
            }
            NSString *mathString = [string substringWithRange:match.range];
            NSString *contentString =[mathString substringWithRange:NSMakeRange(1, mathString.length-2)];
            if ([[CAIExpressionParser shareParser].expressionNames containsObject:contentString]) {//是表情
                [atString appendAttributedString:[self attributedStringWithExpressionName:contentString withDelegateDic:atString]];
            }else{//不是表情
                [atString appendAttributedString:[[NSAttributedString alloc]initWithString:mathString]];
            }
            index = match.range.location+match.range.length;
        }
        if (index<string.length-1) {
            [atString appendAttributedString:[[NSAttributedString alloc]initWithString:[string substringWithRange:NSMakeRange(index,string.length-index)]]];
        }
    }else{
        [atString appendAttributedString:[[NSAttributedString alloc]initWithString:string]];
    }
    return atString;
}

+ (NSAttributedString *)attributedStringWithExpressionName:(NSString *)name withDelegateDic:(NSMutableAttributedString *)mtAtString{
    //生成attachment
    NSTextAttachment *attachment=[[NSTextAttachment alloc]init];
    NSString * imageName = [CAIExpressionParser shareParser].expressionFile[name];
    UIImage *img= [UIImage imageNamed:imageName];
    attachment.image=img;
    attachment.bounds=CGRectMake(0,-4, 20, 20);
    NSAttributedString *text=[NSAttributedString attributedStringWithAttachment:attachment];
    NSMutableAttributedString *atString = [[NSMutableAttributedString alloc]initWithAttributedString:text];
    
    //修改callback
    CTRunDelegateCallbacks callbacks;
    callbacks.version       = kCTRunDelegateVersion1;
    callbacks.getAscent     = RunDelegateGetAscentCallback;
    callbacks.getDescent    = RunDelegateGetDescentCallback;
    callbacks.getWidth      = RunDelegateGetWidthCallback;
    callbacks.dealloc       = RunDelegateDeallocCallback;
    
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (void*)mtAtString);
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)delegate,kCTRunDelegateAttributeName, nil];
    CFRelease(delegate);
    [atString addAttributes:attr range:NSMakeRange(0, 1)];
    
    //设置标签
    [atString addAttribute:@"imageName" value:name range:NSMakeRange(0, 1)];
    
    return atString;
}

+ (NSString*)expressionStringFromAttributedString:(NSAttributedString *)atString{
    NSString * string = atString.string;
    NSError * error = nil;
    unichar objectReplacementChar = 0xFFFC;
    NSString *regTags = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, [string length])];
    
    NSInteger index = 0;
    NSMutableString *mString = [NSMutableString string];
    if (matches.count) {
        for (NSInteger i=0; i<matches.count; i++) {
            NSTextCheckingResult * match = matches[i];
            if (index <match.range.location) {//加载中间的文字
                [mString appendString:[string substringWithRange:NSMakeRange(index, match.range.location-index)]];
                index = match.range.location;
            }
            NSDictionary * dic = [atString attributesAtIndex:match.range.location effectiveRange:NULL];
            if (dic && [dic isKindOfClass:[NSDictionary class]]) {
                NSString * expressionName = dic[@"imageName"];
                if ([[CAIExpressionParser shareParser].expressionNames containsObject:expressionName]) {
                    //判定为表情
                    [mString appendFormat:@"[%@]",expressionName];
                    index++;
                }
            }
        }
    }
    if (index <string.length-1) {//加载中间的文字
        [mString appendString:[string substringWithRange:NSMakeRange(index, string.length-index)]];
    }
    return mString;
}

+ (CGSize)fitSizeWithAttributedString:(NSAttributedString *)atString inSize:(CGSize)inSize{
    inSize.height = MAXFLOAT;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)(atString));
    CGSize suggestSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, atString.length), NULL, inSize, NULL);
    suggestSize.width = inSize.width;
    return suggestSize;
}

+ (void)updateExpressionSizeInAttributeString:(NSMutableAttributedString *)mtAtString{
    NSString * string = mtAtString.string;
    NSError * error = nil;
    unichar objectReplacementChar = 0xFFFC;
    NSString *regTags = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, [string length])];
    
    for(NSInteger i=0;i<matches.count;i++){
        NSTextCheckingResult * match = matches[i];
        NSDictionary * dic = [mtAtString attributesAtIndex:match.range.location effectiveRange:NULL];
        if (dic) {
            NSTextAttachment *attachment = dic[@"NSAttachment"];
            NSString * expressionName = dic[@"imageName"];
            if ([[CAIExpressionParser shareParser].expressionNames containsObject:expressionName] && attachment) {
                CGFloat fontSize = [UIFont systemFontSize];
                UIFont * font = dic[NSFontAttributeName];
                if (font) {
                    fontSize = font.pointSize;
                }
                attachment.bounds = CGRectMake(0, -fontSize*0.2, fontSize*1.2, fontSize*1.2);
            }
        }
    }
}

@end
