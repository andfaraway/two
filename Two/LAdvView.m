//
//  LAdvView.m
//  Two
//
//  Created by li.bin on 16/8/19.
//  Copyright © 2016年 ryt. All rights reserved.
//  

#import "LAdvView.h"
#import "UIImageView+WebCache.h"

#define WIDTH self.frame.size.width
#define HEIGHT self.frame.size.height


@interface LAdvView()<UIScrollViewDelegate>

@end

@implementation LAdvView
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSTimer *_timer;        //计时器
    NSMutableArray *_picArr;        //广告图片循环数组
    BOOL flag;
}

- (instancetype)initWithFrame:(CGRect)frame andPicArr:(NSArray *)picArr{
    self = [super initWithFrame:frame];

    if (picArr) {
        _picArr = [NSMutableArray arrayWithArray:picArr];
    }else{
        _picArr = [NSMutableArray new];
    }
    //当图片需要循环时，最后面添加第一张图
    if (picArr.count > 1) {
        [_picArr addObject:[picArr firstObject]];
    }
    
    //滚动背景
    _scrollView = [[UIScrollView alloc]initWithFrame:self.frame];
    [self addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor lightGrayColor];
    _scrollView.delegate = self;

    _scrollView.contentSize = CGSizeMake(_picArr.count * self.frame.size.width, 0);
    _scrollView.pagingEnabled = YES;
    
    //隐藏滚动条
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    //scrollerView上面添加滚动广告
    for (int i=0; i < _picArr.count; i++) {
        //获取广告图片信息
        NSDictionary *dic = _picArr[i];
        NSURL *imgUrl = [dic objectForKey:@"imgUrl"];//图片地址
        
        //创建imageView
        UIImageView *imgV = [[UIImageView alloc]init];
        imgV.frame = CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        imgV.backgroundColor = [UIColor whiteColor];
        imgV.tag = 400+i;
        imgV.userInteractionEnabled = YES;
        [imgV sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:DefaultImg]];
        
        //添加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpWithSafri:)];
        [imgV addGestureRecognizer:tap];
        
        [_scrollView addSubview:imgV];
    }
#ifdef ISSCROLL
    //定时滚动(当图片张数大于2)
    if (picArr.count >= 2) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollViewRun) userInfo:nil repeats:YES];
    }
#endif
    
    //添加标识点
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _pageControl.centerX = self.centerX;
    _pageControl.y = self.size.height - 20;
    _pageControl.hidesForSinglePage = YES;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.numberOfPages = picArr.count;
    [self addSubview:_pageControl];
    
    //添加删除按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImageView *deleteImg = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH-30, 8, 22, 22)];
    deleteImg.image = [UIImage imageNamed:@"delete"];
    [self addSubview:deleteImg];
    deleteBtn.frame = CGRectMake(CGRectGetMaxX(self.frame)-44,0, 44, 44);
    deleteBtn.backgroundColor = [UIColor clearColor];
    [deleteBtn addTarget:self action:@selector(removeAdv) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteBtn];
    return self;
}

//超链接
- (void)jumpWithSafri:(UITapGestureRecognizer *)tgr
{
    UIView *view = tgr.view;
    NSDictionary *dic = [_picArr objectAtIndex:view.tag - 400];
    NSURL *url = [NSURL URLWithString:[dic objectForKey:@"jumpUrl"]];
    [[UIApplication sharedApplication]openURL:url];
    NSLog(@"url = %@",url);
}


//定时器
- (void)scrollViewRun
{
    [UIView animateWithDuration:1 animations:^{
        CGFloat x = _scrollView.contentOffset.x;
        x += WIDTH;
        _scrollView.contentOffset = CGPointMake(x, 0);
    }];
    
}

#pragma mark - 移除广告栏
- (void)removeAdv
{
    [self removeFromSuperview];
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - scrollerViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
#ifdef ISSCROLL
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollViewRun) userInfo:nil repeats:YES];
    }
#endif
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x >= scrollView.contentSize.width - WIDTH) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }else if (scrollView.contentOffset.x < 0){
        scrollView.contentOffset = CGPointMake(scrollView.contentSize.width - WIDTH-1, 0);
    }
    //pageControl点数对应
    _pageControl.currentPage = (int)(scrollView.contentOffset.x/WIDTH +0.5);
}

//重新设定图片frame
- (void)resetFrame
{
    UIImageView *firstImgV = [_scrollView.subviews firstObject];
    [_scrollView bringSubviewToFront:firstImgV];
    for (int i=0; i<_scrollView.subviews.count; i++) {
        UIImageView *imgView = [_scrollView.subviews objectAtIndex:i];
        imgView.frame = CGRectMake(i * WIDTH, 0, WIDTH,HEIGHT);
    }
}

@end
