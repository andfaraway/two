//
//  DeckViewController.h
//  DeckViewController
//
//  Created by aReu on 15/09/18.
//  Copyright (c) 2015年 aReu. All rights reserved.

#import <UIKit/UIKit.h>
#import "UIView_extra.h"

@interface DeckViewController : UIViewController

@property (nonatomic, strong) UIViewController *leftVC;
@property (nonatomic,strong) UIViewController *mainVC;
/*
    滑动视图效果 默认开
 */
@property (nonatomic, strong) UITapGestureRecognizer *sideslipTapGes;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

//当前视图状态 NO为开
@property (nonatomic, assign) BOOL closed;
/*
 滑动速度，默认为0.5;
 */
@property (nonatomic, assign) CGFloat speedf;

- (void)setPanEnabled: (BOOL) enabled;

- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andMainView:(UIViewController *)mainVC;

- (void)closeLeftView;

- (void)openLeftView;

-(void)refreshCurrentViewForSharePoint:(NSNotification*)nocation;
@end
