//
//  Flashlight.h
//  Two
//
//  Created by li.bin on 16/9/6.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface Flashlight : NSObject
{
    BOOL isLightOn;
    AVCaptureDevice *device;
}

-(void) turnOnLed:(bool)update;

@end
