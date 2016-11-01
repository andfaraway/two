//
//  Joker.m
//  Two
//
//  Created by li.bin on 16/8/30.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "Joker.h"
#import "Masonry.h"
#import "PresentModal.h"
@interface Joker ()<UIViewControllerTransitioningDelegate>
{
    UIButton *textBtn;
    NSDictionary *jokerDic;
    PresentModal *presentAnimation;
}

@end

@implementation Joker

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveJokerMessage:) name:@"jokerMessage" object:nil];
    self.title = NSStringFromClass([self class]);
    self.view.backgroundColor = [UIColor whiteColor];
    
    presentAnimation = [PresentModal new];
    self.transitioningDelegate = self;
    
    
    //显示文字
    textBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    textBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH);
    textBtn.layer.cornerRadius = SCREEN_WIDTH/2;
    [textBtn addTarget:self action:@selector(tapTextLabel) forControlEvents:UIControlEventTouchUpInside];
    textBtn.backgroundColor = CRGB(97, 173, 252, 1);
    textBtn.titleLabel.numberOfLines = 0;
    [self.view addSubview:textBtn];
    
    
}
//点击文本
- (void)tapTextLabel
{
    if (jokerDic) {
        NSArray *arr = jokerDic[@"showapi_res_body"][@"contentlist"];
        NSInteger n = jokerDic.count;
        NSInteger s = arc4random()%n;
        NSLog(@"%ld",(long)s);
        NSDictionary *dic = arr[s];
        NSString *textStr = [dic objectForKey:@"text"];
        NSArray *texts = [textStr componentsSeparatedByString:@"<p>"];
        [textBtn setTitle:textStr  forState:UIControlStateNormal];
    }
}

- (void)receiveJokerMessage:(NSNotification *)notification
{
    jokerDic = [NSDictionary dictionaryWithDictionary: notification.object];
    NSArray *arr = jokerDic[@"showapi_res_body"][@"contentlist"];
    NSDictionary *dic = arr[0];
    [textBtn setTitle:@"Refresh"  forState:UIControlStateNormal];
}

-(void)viewWillAppear:(BOOL)animated
{
    //添加约束
    [textBtn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(SCREEN_WIDTH);

    }];
}

#pragma mark -UIViewControllerTransitioningDelegate代理方法
//presenting
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    presentAnimation.animationType = AnimationTypePresent;
    return presentAnimation;
}
//dismiss
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    presentAnimation.animationType = AnimationTypeDismiss;
    return presentAnimation;
}


@end
