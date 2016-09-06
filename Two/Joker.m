//
//  Joker.m
//  Two
//
//  Created by li.bin on 16/8/30.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "Joker.h"
#import "Masonry.h"

@interface Joker ()
{
    UIButton *textBtn;
    NSDictionary *jokerDic;
}

@end

@implementation Joker

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveJokerMessage:) name:@"jokerMessage" object:nil];
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    //显示文字
    textBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    textBtn.frame = CGRectMake(0, 0, 200, 200);
    textBtn.layer.cornerRadius = 100;
    [textBtn addTarget:self action:@selector(tapTextLabel) forControlEvents:UIControlEventTouchUpInside];
    textBtn.backgroundColor = CRGB(97, 173, 252, 1);
    [self.view addSubview:textBtn];
    
    
}
//点击文本
- (void)tapTextLabel
{
    
}

- (void)receiveJokerMessage:(NSNotification *)notification
{
    jokerDic = [NSDictionary dictionaryWithDictionary: notification.object];
    NSArray *arr = jokerDic[@"showapi_res_body"][@"contentlist"];
    NSDictionary *dic = arr[0];
    [textBtn setTitle:[dic objectForKey:@"text"]  forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    //添加约束
    [textBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(200);
        make.height.equalTo(200);

    }];
}


@end
