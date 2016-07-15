//
//  LGuidePage.m
//  Two
//
//  Created by li.bin on 16/7/15.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "LGuidePage.h"


@implementation LGuidePage
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)addV
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    //设置滑动scrollView
    self.frame =CGRectMake(0, 0, width,height);
    self.contentSize = CGSizeMake(width * _picArr.count, 0);
    self.pagingEnabled = YES;
    //放上对应的引导图片
    for (NSInteger i=0; i<_picArr.count; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.frame = CGRectMake(width * i, 0, width, height);
        imageView.image = [UIImage imageNamed:[_picArr objectAtIndex:i]];
        [self addSubview:imageView];
        //最后一张放上确认按钮
        if (i == (_picArr.count-1)) {
            UIButton *tureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            tureBtn.frame = CGRectMake((width -150)/2, height-100, 150, 50);
            tureBtn.backgroundColor = [UIColor cyanColor];
            [tureBtn setTitle:@"GO" forState:UIControlStateNormal];
            tureBtn.layer.cornerRadius = 5;
            [tureBtn addTarget: self action:@selector(hideGuidePage) forControlEvents:UIControlEventTouchUpInside];
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:tureBtn];
        }
    }
    [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:@"numberOfStarts"];
    //添加显示页面的点
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, height - 50, width, 30)];
    [self.superview addSubview:_pageControl];
    _pageControl.numberOfPages = _picArr.count;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
}


//移除页面
- (void)hideGuidePage
{
    [self removeFromSuperview];
    [_pageControl removeFromSuperview];
}


@end
