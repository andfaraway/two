//
//  ViewController.m
//  Two
//
//  Created by ryt on 16/6/27.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self showImage];
}

- (void)showImage
{
    NSString *str = @"/club/cardPortals/adv/20160627100000000242_second41416.jpg";
    UIImage *img = [UIImage imageWithContentsOfFile:str];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgView.image = img;
    [self.view addSubview:imgView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
