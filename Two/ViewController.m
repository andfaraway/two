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
#import "Joker.h"
#import "Contact.h"
@interface ViewController ()

@end

@implementation ViewController

//重写init方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainVC" bundle:[NSBundle mainBundle]];
        self = [storyBoard instantiateViewControllerWithIdentifier:@"firstView"];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"1111111");
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:174/255.0 green:225/255.0 blue:198/255.0 alpha:1];
    self.title = @"Test";
    //导航栏是否半透明
    self.navigationController.navigationBar.translucent = NO;
    if (VERSION >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    [self random];
}
     
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"222222");

    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT );
}

//button随机排布
- (void)random
{
    NSLog(@"133331");

    for (int i=100; i<104 ;i++){
        CGFloat rx = arc4random()%(int)SCREEN_WIDTH;
        CGFloat ry = arc4random()%(int)SCREEN_HEIGHT+50;
        CGPoint  rPoint = CGPointMake(rx, ry);
        UIButton *button = [self.view viewWithTag:i];
        button.frame = CGRectMake(0, 0, 100, 50);
        button.center = rPoint;
    }
}
//跳转联系人页面
- (IBAction)Contect:(id)sender {
    Contact *contact = [Contact new];
    [contact openContact:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
