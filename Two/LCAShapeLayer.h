//
//  LCAShapeLayer.h
//  Two
//
//  Created by li.bin on 16/7/25.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCAShapeLayer : UIView
{
    double add;
    NSTimer *_timer;
}

@property(nonatomic,strong)CAShapeLayer * shapeLayer;
- (void)gogogogo;
#define pi 3.14159265359

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式
@end