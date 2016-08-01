//
//  LCAShapeLayerVC.m
//  Two
//
//  Created by li.bin on 16/7/25.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "LCAShapeLayerVC.h"
#import "LCAShapeLayer.h"
@interface LCAShapeLayerVC ()

@end

@implementation LCAShapeLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    LCAShapeLayer *lc = [[LCAShapeLayer alloc]init];
    lc.backgroundColor= [UIColor whiteColor];
    lc.frame = self.view.frame;
    [self.view addSubview:lc];
    [lc gogogogo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
