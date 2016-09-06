//
//  BackgroundView.m
//  Two
//
//  Created by li.bin on 16/8/29.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "BackgroundView.h"
#import "AFHTTPRequestOperationManager.h"
#import "Flashlight.h"
@implementation BackgroundView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self = [[NSBundle mainBundle]loadNibNamed:@"BackgroundView" owner:nil options:nil][0];
    }
    return self;
}
#pragma mark - joker
- (IBAction)joker:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"joker" object:self userInfo:nil];
    
    NSString *httpUrl = @"http://apis.baidu.com/showapi_open_bus/showapi_joke/joke_text";
    NSString *httpArg = @"page=1";
    
    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL: url cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval: 10];
    [request setHTTPMethod: @"GET"];
    [request addValue: @"fa8f1e59b4ef852d677adcaae8a29dbb" forHTTPHeaderField: @"apikey"];
    [self downloadMessage:request];
    
}


- (void)downloadMessage:(NSURLRequest *)request
{
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableLeaves error:nil];
        
        //写入document文件
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths firstObject];
        NSLog(@"path:%@",path);
        [[NSNotificationCenter defaultCenter]postNotificationName:@"jokerMessage" object:dic];
        [dic writeToFile:[NSString stringWithFormat:@"%@/%@",path,@"jeson.plist"] atomically:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [operation start];
}

#pragma mark - flashlight
- (IBAction)flashlight:(id)sender {
    UIButton *button = sender;
    Flashlight *flashlight = [Flashlight new];
    static BOOL isON = YES;
    [flashlight turnOnLed:isON];
    //根据状态调整button title
    if (isON) {
        [button setTitle:@"off" forState:UIControlStateNormal];
    }else{
        [button setTitle:@"on" forState:UIControlStateNormal];
    }
    

    //更改状态
    isON = !isON;
}

@end
