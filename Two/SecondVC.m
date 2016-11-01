//
//  SecondVC.m
//  Two
//
//  Created by li.bin on 16/9/28.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "SecondVC.h"
#import "Modal.h"
@interface SecondVC ()<UIViewControllerTransitioningDelegate>

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"presented" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 80, 80);
    button.layer.cornerRadius = 40;
    button.backgroundColor = [UIColor cyanColor];
    button.center = self.view.center;
    [button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -UIViewControllerTransitioningDelegate代理方法
//presenting
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    Modal *modal = [[Modal alloc]init];
    return modal;
}
//dismiss
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    Modal *modal = [[Modal alloc]init];
    return modal;
}
@end
