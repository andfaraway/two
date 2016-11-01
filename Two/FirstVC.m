//
//  FirstVC.m
//  Two
//
//  Created by li.bin on 16/9/28.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "FirstVC.h"
#import "SecondVC.h"
#import "Modal.h"
@interface FirstVC ()<UIViewControllerTransitioningDelegate>

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitioningDelegate = self;
    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
}
- (IBAction)presenting:(id)sender {
    SecondVC *svc = [[SecondVC alloc]init];
    [self presentViewController:svc animated:YES completion:nil];
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
