//
//  LCAShapeLayer.m
//  Two
//
//  Created by li.bin on 16/7/25.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "LCAShapeLayer.h"

@implementation LCAShapeLayer

- (void)gogogogo
{
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.frame = CGRectMake(0, 0, 300, 300);
    self.shapeLayer.position = self.center;
    self.shapeLayer.fillColor = [UIColor blackColor].CGColor;
    
    //设置线条属性
    self.shapeLayer.lineWidth = 5;
    self.shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    
    //路径
    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150)//圆心坐标
                                                         radius:75//圆的半径
                                                     startAngle:degreesToRadians(0)//起始角度
                                                       endAngle:degreesToRadians(300)//结束角度
                                                      clockwise:YES];//YES or NO(顺时针 或 逆时针)
   
    
    aPath.lineCapStyle = kCGLineCapButt; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    [aPath closePath];// (终点坐标,连回起点坐标)
    [aPath moveToPoint:self.center];
    
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    self.shapeLayer.path = aPath.CGPath;
    [self.layer addSublayer:self.shapeLayer];
    
    
#pragma mark - 定时器
    add = 0.1;//每次递增0.1
    //用定时器模拟数值输入的情况
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2
                                              target:self
                                            selector:@selector(circleAnimationTypeOne)
                                            userInfo:nil
                                             repeats:YES];
}

//定时器方法
- (void)circleAnimationTypeOne
{
    if (self.shapeLayer.strokeEnd > 1 && self.shapeLayer.strokeStart < 1)
    {
        //  self.shapeLayer.strokeStart += add;
        
        [_timer invalidate];//取消定时器
        _timer = nil;//定时器指向空
        
    }
    else if(self.shapeLayer.strokeStart == 0)
    {
        self.shapeLayer.strokeEnd += add;
    }
    
    if (self.shapeLayer.strokeEnd == 0)
    {
        self.shapeLayer.strokeStart = 0;
    }
    
    if (self.shapeLayer.strokeStart == self.shapeLayer.strokeEnd)
    {
        self.shapeLayer.strokeEnd = 0;
    }
}

@end
