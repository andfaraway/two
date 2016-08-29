//
//  ViewController.m
//  Two
//
//  Created by ryt on 16/6/27.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "ViewController.h"
#import "DeckViewController.h"
#import "LAdvView.h"
#import "BackgroundView.h"
@interface ViewController ()

@end

@implementation ViewController

//重写init方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainVC" bundle:[NSBundle mainBundle]];
        self = [storyBoard instantiateInitialViewController];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = YES;
    if (VERSION >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//    CGPoint center = self.view.window.center;
//r
//    CGAffineTransform tf = CGAffineTransformIdentity;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.view.transform = CGAffineTransformScale(tf, 0.7, 0.7);
//        self.view.center = CGPointMake(center.x, center.y+100);
//    }];
    [self random];
}
     
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT );
}

//button随机排布
- (void)random
{
    for (int i=100; i<104 ;i++){
        CGFloat rx = arc4random()%(int)SCREEN_WIDTH;
        CGFloat ry = arc4random()%(int)SCREEN_HEIGHT+50;
        CGPoint  rPoint = CGPointMake(rx, ry);
        UIButton *button = [self.view viewWithTag:i];
        button.frame = CGRectMake(0, 0, 100, 50);
        button.center = rPoint;
    }
}

- (IBAction)cehua:(id)sender {
 
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
