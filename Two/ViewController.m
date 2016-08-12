//
//  ViewController.m
//  Two
//
//  Created by ryt on 16/6/27.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "ViewController.h"
#import "DeckViewController.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)viewWillAppear:(BOOL)animated
{
    CGPoint center = self.view.window.center;

    CGAffineTransform tf = CGAffineTransformIdentity;
    [UIView animateWithDuration:5 animations:^{
        self.view.transform = CGAffineTransformScale(tf, 0.7, 0.7);
        self.view.center = CGPointMake(center.x, center.y+100);
    }];
}
     
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

- (IBAction)cehua:(id)sender {
    UIViewController *leftVC = [[UIViewController alloc]init];
    leftVC.view.backgroundColor = [UIColor orangeColor];
    UIViewController *mainVC = [[UIViewController alloc]init];
    mainVC.view.backgroundColor = [UIColor cyanColor];
    DeckViewController *dec = [[DeckViewController alloc]initWithLeftView:leftVC andMainView:mainVC];
    [self presentViewController:dec animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
