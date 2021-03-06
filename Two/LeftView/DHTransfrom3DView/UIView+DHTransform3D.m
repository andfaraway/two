//
//  UIView+DHTransform3D.m
//  3DControlling
//
//  Created by DreamHack on 15-10-19.
//  Copyright (c) 2015年 DreamHack. All rights reserved.
//

#import "UIView+DHTransform3D.h"
#import "DHVector.h"
#import <objc/runtime.h>

static const CGFloat maxTranslate_ = 400.f;

static const CGFloat maxRotateRadian_ = M_PI ;

static const void * lastTranslationKey = &lastTranslationKey;
static const void * transformUnitKey = &transformUnitKey;

@implementation UIView (DHTransform3D)

// 使用OC的动态特性添加属性
@dynamic transformUnit;

- (DHVector *)lastTranslation{
    return objc_getAssociatedObject(self, lastTranslationKey);
}

- (void)setLastTranslation:(DHVector *)lastTranslation
{
    objc_setAssociatedObject(self, lastTranslationKey, lastTranslation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)transformUnit
{
    return [objc_getAssociatedObject(self, transformUnitKey) floatValue];
}

- (void)setTransformUnit:(CGFloat)transformUnit
{
    objc_setAssociatedObject(self, transformUnitKey, @(transformUnit), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)prepareForTransform3D
{
    CATransform3D transform = self.layer.transform;
    // 设置旋转透视效果
    transform.m34 = -1.f/700;
    
    self.layer.transform = transform;
}

- (void)setTransform3DWithPanTranslation:(CGPoint)panTranslation
{
    // 我们要的向量是手指上次所在的点到这次所在的点连成的一个向量，这是你这次手指滑动的方向，传给transform3DRotate函数的向量是垂直于这个向量的向量。而我们已知的只有这个transition，也就是手指最开始的点到手指当前点连成的一个向量（也就是手指的位移，只考虑起始点和结束点）。
    // 画出图来就发现，我们要的向量就是当前向量-上一次手指的位移向量（向量减法）
    
    // 通过这个位移生成一个向量。
    DHVector * vector = [[DHVector alloc] initWithCoordinateExpression:panTranslation];
    
    // 用当前的位移向量-上次的位移向量得到我们手指的位移偏移量
    DHVector * translateVector = [DHVector aVector:vector substractedByOtherVector:[self lastTranslation]];
    // 把这个向量保存起来，下次调用这个方法的时候需要拿到这次的向量，用来做减法
    [self setLastTranslation:vector];
    
    // 随便计算一下单位旋转角度，也就是每次调用这个方法的时候应该旋转多少度
    
    CGFloat radian = self.transformUnit / maxTranslate_ * maxRotateRadian_;
    
    // 生成旋转向量，也就是要传给CATransform3DRotate函数的向量，它通过translateVector顺时针旋转90度（PI/2）得到
    DHVector * rotateVector = [DHVector vectorWithVector:translateVector];
//    [rotateVector rotateClockwiselyWithRadian:M_PI/2];
    [rotateVector rotateAntiClockwiselyWithRadian:M_PI/2];
    // 把起始点平移至原点，这样就是向量的坐标形式
    [rotateVector translationToPoint:CGPointZero];
    // 把旋转向量传给函数
    CATransform3D transRotate = CATransform3DRotate(self.layer.transform, radian, 0,  rotateVector.endPoint.y, 0);
    CGFloat scalePercent = panTranslation.x/SCREEN_WIDTH;
    if ((1-scalePercent) > 0.5) {
        CATransform3D tranScale = CATransform3DScale(CATransform3DIdentity,0.99, 0.99, 1);
        self.layer.transform = CATransform3DConcat(transRotate, tranScale);
    }
}

- (void)zoomWithPinchScale:(CGFloat)pinchScale{
}

- (void)rotateByZWithRadian:(CGFloat)radian{
}

@end
