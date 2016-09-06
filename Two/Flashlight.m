//
//  Flashlight.m
//  Two
//
//  Created by li.bin on 16/9/6.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "Flashlight.h"

@implementation Flashlight

- (instancetype)init
{
    self = [super init];
    if (self) {
        //AVCaptureDevice代表抽象的硬件设备
        // 找到一个合适的AVCaptureDevice
        device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        isLightOn = NO;
    }
    return self;
}

-(void) turnOnLed:(bool)update
{
    if (![device hasTorch]) {//判断是否有闪光灯
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前设备没有闪光灯，不能提供手电筒功能" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alter show];
    }else
    {
        //闪光灯状态
        AVCaptureTorchMode torchMode;
        if (update) {
            torchMode = AVCaptureTorchModeOn;
        }else{
            torchMode = AVCaptureTorchModeOff;
        }
        
        [device lockForConfiguration:nil];
        [device setTorchMode:torchMode];
        [device unlockForConfiguration];
    }
}

@end
