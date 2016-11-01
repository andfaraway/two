//
//  Modal.h
//  Two
//
//  Created by li.bin on 16/9/28.
//  Copyright © 2016年 ryt. All rights reserved.
//

typedef enum {
    
    AnimationTypePresent,
    
    AnimationTypeDismiss
    
} AnimationType;
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PresentModal : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) AnimationType animationType;
@end
