//
//  Modal.m
//  Two
//
//  Created by li.bin on 16/9/28.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "PresentModal.h"


@implementation PresentModal
//持续时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}
//动画效果
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];



    UIView * toView = toViewController.view;

    UIView * fromView = fromViewController.view;



    if (self.animationType == AnimationTypePresent) {
        //snapshot方法是很高效的截屏
        
        //fromView放上面
        
        UIView * snap = [fromView snapshotViewAfterScreenUpdates:YES];
        
        [transitionContext.containerView addSubview:snap];
        
        //toView放下面
        
        UIView * snap2 = [toView snapshotViewAfterScreenUpdates:YES];
        
        [transitionContext.containerView addSubview:snap2];
        
        
        
        snap2.transform = CGAffineTransformMakeTranslation(SCREEN_WIDTH, 0);
        
      
        [UIView animateWithDuration:0.4 animations:^{
            snap2.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            //删掉截图
            
            [snap removeFromSuperview];
            
            [snap2 removeFromSuperview];
            
            //添加视图
            
            [[transitionContext containerView] addSubview:toView];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            
        }];
    }else
    {
        //fromView放下面
        
        UIView * snap = [fromView snapshotViewAfterScreenUpdates:YES];
        [transitionContext.containerView addSubview:snap];

        
        //toView放上面
        
        UIView * snap2 = [toView snapshotViewAfterScreenUpdates:YES];
        
        [transitionContext.containerView addSubview:snap2];

        
        
        snap2.transform = CGAffineTransformMakeTranslation(-SCREEN_WIDTH, 0);
        
        
        [UIView animateWithDuration:0.4 animations:^{
            snap2.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {
            //删掉截图
            
            [snap removeFromSuperview];

            [snap2 removeFromSuperview];

            //添加视图

            [[transitionContext containerView] addSubview:toView];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}



@end
