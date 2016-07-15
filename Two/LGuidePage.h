//
//  LGuidePage.h
//  Two
//
//  Created by li.bin on 16/7/15.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGuidePage : UIScrollView
@property (nonatomic ,strong)NSArray *picArr;
@property (nonatomic ,strong)NSArray *urlArr;
@property (nonatomic ,strong)UIPageControl *pageControl;
- (void)addV;
@end
