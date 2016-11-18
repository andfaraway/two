//
//  Modal.m
//  Two
//
//  Created by li.bin on 16/9/28.
//  Copyright © 2016年 li.bin All rights reserved.
//

#import "Modal.h"

@implementation Modal
//持续时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}
//动画效果
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //1.获取源控制器与目标控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC  = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    //设置toVC的frame
    fromVC.view.backgroundColor = [UIColor orangeColor];
    toVC.view.backgroundColor = [UIColor purpleColor];
    toVC.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    //3.设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
//
//    toVC.view.frame = transitionContext.finalFrameForViewController(toVC)
//    toVC.view.alpha = 0
    
    //4.都添加到 container 中。注意顺序不能错了
//    [container addSubview:fromVC.view];
//    [container addSubview:toVC.view];
    //5.执行动画
    
    [UIView animateWithDuration:2 animations:^{
        toVC.view.frame = [UIScreen mainScreen].bounds;
    }];
    
    
//    UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//        snapshotView.frame = toVC.avatarImageView.frame
//        toVC.view.alpha = 1
//    }) { (finish: Bool) -> Void in
//        fromVC.selectedCell.imageView.hidden = false
//        toVC.avatarImageView.image = toVC.image
//        snapshotView.removeFromSuperview()
//        
//        //一定要记得动画完成后执行此方法，让系统管理 navigation
//        transitionContext.completeTransition(true)
//    }
}

@end
