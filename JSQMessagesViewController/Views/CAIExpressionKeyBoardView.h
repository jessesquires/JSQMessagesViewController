//
//  CAIExpressionKeyBoardView.h
//  CAIExpressionDemo
//
//  Created by liyufeng on 15/5/12.
//  Copyright (c) 2015年 liyufeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CAIExpressionKeyBoardView;
@protocol CAIExpressionKeyBoardDelegate <NSObject>

@optional
// expressionName 为 delete 时 为删除键
- (void)keyBoard:(CAIExpressionKeyBoardView*)keyBoard didSeleted:(NSString *)expressionName;

@end

@interface CAIExpressionKeyBoardView : UIView

@property (nonatomic, weak)id<CAIExpressionKeyBoardDelegate> delegate;

@end
