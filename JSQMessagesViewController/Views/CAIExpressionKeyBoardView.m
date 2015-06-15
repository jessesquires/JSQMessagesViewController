//
//  CAIExpressionKeyBoardView.m
//  CAIExpressionDemo
//
//  Created by liyufeng on 15/5/12.
//  Copyright (c) 2015年 liyufeng. All rights reserved.
//

#import "CAIExpressionKeyBoardView.h"
#import "CAIExpressionParser.h"

#define EXPRESSION_WIDTH 43.0
#define EXPRESSION_IMAGE_WIDTH 27.0

@interface CAIExpressionKeyBoardView ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIToolbar *backgroundView;
@property (nonatomic, strong)UIScrollView * scrollView;
@property (nonatomic, strong)UIPageControl * pageControl;
@property (nonatomic, strong)UIButton *sendButton;
@end


@implementation CAIExpressionKeyBoardView

- (instancetype)initWithFrame:(CGRect)frame
{
    float width = [UIScreen mainScreen].bounds.size.width;
    frame = CGRectMake(0, 0, width, 180);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundView = [[UIToolbar alloc]init];
        self.backgroundView.frame = self.bounds;
        [self addSubview:self.backgroundView];
        
        NSInteger count = (NSInteger)(width/EXPRESSION_WIDTH);
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, width, EXPRESSION_WIDTH*3)];
        NSInteger coutOfPage = (([CAIExpressionParser shareParser].expressionNames.count+(count*3-1)-1)/(count*3-1));
        for (NSInteger i=0; i<coutOfPage; i++) {
            UIView * oneKeyBoard = [self oneKeyBoardWithIndex:i lineCount:count];
            [self.scrollView addSubview:oneKeyBoard];
        }
        self.scrollView.contentSize = CGSizeMake(width*coutOfPage, EXPRESSION_WIDTH*3);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        //添加pagecontrol
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.scrollView.frame.origin.y+self.scrollView.frame.size.height+10, width, 10)];
        [self addSubview:self.pageControl];
        self.pageControl.numberOfPages = coutOfPage;
        self.pageControl.currentPage = 0;
        self.pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
        [self.pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
        self.scrollView.delegate = self;
    }
    return self;
}

- (UIView *)oneKeyBoardWithIndex:(NSInteger)index lineCount:(NSInteger)lineCount{
    float width = [UIScreen mainScreen].bounds.size.width;
    float x = (width - EXPRESSION_WIDTH * lineCount)/2;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(width*index, 0, width, EXPRESSION_WIDTH*3)];
    NSInteger pageCount = lineCount*3;
    NSInteger longIndex = (pageCount-1)*index;
    NSInteger endIndex = longIndex+lineCount*3-1;
    
    NSArray *expressionNames = [CAIExpressionParser shareParser].expressionNames;
    if (endIndex>=expressionNames.count) {
        endIndex=expressionNames.count;
    }
    NSArray * arr = [expressionNames subarrayWithRange:NSMakeRange(longIndex, endIndex-longIndex)];
    arr = [arr arrayByAddingObject:@"delete"];
    
    for (NSInteger i=0; i<arr.count; i++) {
        NSString * expressName = arr[i];
        UIButton * button = [self buttonWithExpressionName:expressName];
        CGRect frame = button.frame;
        frame.origin = CGPointMake(x+EXPRESSION_WIDTH*(i%lineCount), EXPRESSION_WIDTH*(i/lineCount));
        button.frame = frame;
        [view addSubview:button];
    }
    return view;
}

- (UIButton *)buttonWithExpressionName:(NSString *)expressionName{
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, EXPRESSION_WIDTH, EXPRESSION_WIDTH )];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if(expressionName && [expressionName isEqualToString:@"delete"]){
        [button setImage:[UIImage imageNamed:[CAIExpressionParser shareParser].keyBoardDeleteIcon] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[CAIExpressionParser shareParser].keyboardDeleteIconHL] forState:UIControlStateHighlighted];
        button.tag = -1;
    }else{
        [button setImage:[UIImage imageNamed:[CAIExpressionParser shareParser].expressionFile[expressionName]] forState:UIControlStateNormal];
        button.tag = [[CAIExpressionParser shareParser].expressionNames indexOfObject:expressionName];
    }
    return button;
}

- (void)buttonClicked:(UIButton *)button{
    NSString * expressionName = nil;
    if (button.tag>=0) {
        expressionName = [CAIExpressionParser shareParser].expressionNames[button.tag];
    }else{
        expressionName = @"delete";
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyBoard:didSeleted:)]) {
        [self.delegate keyBoard:self didSeleted:expressionName];
    }
}

- (void)pageControlChanged:(UIPageControl *)pageControl{
    CGFloat x = self.scrollView.bounds.size.width *pageControl.currentPage;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = (NSInteger)(scrollView.contentOffset.x/scrollView.bounds.size.width);
    self.pageControl.currentPage = index;
}
@end
