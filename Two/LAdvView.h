//
//  LAdvView.h
//  Two
//
//  Created by li.bin on 16/8/19.
//  Copyright © 2016年 ryt. All rights reserved.
//  广告

#import <UIKit/UIKit.h>

#define DefaultImg @"bgIMG"
//是否自动滚动
#define ISSCROLL

@interface LAdvView : UIView
/************
 eg:
 NSArray *picArr = @[@{@"imgUrl":@"http://imgsrc.baidu.com/forum/pic/item/f3f0d9fc1e178a8281800e78f603738dab77e884.jpg",
 @"jumpUrl":@"http://www.baidu.com"},
 @{@"imgUrl":@"http://p0.qhimg.com/t01d30616fa0610059b.jpg?size=1500x1000",
 @"jumpUrl":@"http://www.sina.com"},
 @{@"img":@""},
 @{@"imgUrl":@"http://p0.qhimg.com/t01d30616fa0610059b.jpg?size=320x480",
 @"jumpUrl":@"http://www.tencent.com"},
 ];
*************/
- (instancetype)initWithFrame:(CGRect)frame andPicArr:(NSArray *)picArr;
@end
