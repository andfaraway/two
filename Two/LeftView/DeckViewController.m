//
//  LeftSlideViewController.m
//  LeftSlideViewController
//
//  Created by aReu on 15/09/18.
//  Copyright (c) 2015年 aReu. All rights reserved.

#import "DeckViewController.h"
#import "LLeftView.h"
#import "UIView+DHTransform3D.h"
//#import "CKReflectionImage.h"
#import "UIView_extra.h"

#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height
#define kMainPageDistance   165*([UIScreen mainScreen].bounds.size.width)/320   //打开左侧窗时，中视图(右视图)露出的宽度
#define kMainPageScale   0.8  //打开左侧窗时，中视图(右视图）缩放比例
#define kLeftAlpha 0.9
#define kLeftCenterX 30
#define kLeftScale 0.7 //左侧初始缩放比例
#define ANIMATION_SPEED 0.4 //默认初始速度
#define LAYER_HEIGHT 10//阴影微调
#define SUDO 10 //手感
#define BAR_HEIGHT  [UIApplication sharedApplication].statusBarFrame.size.height

@interface DeckViewController ()<UIGestureRecognizerDelegate>{
    UITableView *_leftTableview;
    UIView      *_contentView;
}
@end

@implementation DeckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)refreshCurrentViewForSharePoint:(NSNotification*)nocation{
    CGFloat y = BAR_HEIGHT;
    if ([UIApplicationWillChangeStatusBarFrameNotification isEqualToString:nocation.name]) {
        _mainVC.view.y = 20;
        if (40 == y) {
        }else{
            self.view.y = 0;
        }
    }else{
        if (40 == y) {
            _mainVC.view.y = 0;
            self.view.y = 20;
        }else{
            self.view.y = 0;
        }
    }
    if (!_closed) {
        [self closeLeftView];
        CGFloat height;
        if (40 == BAR_HEIGHT) {
            height = 20;
        }else height = -20;
        _mainVC.view.height += height;
    }
}

- (instancetype)initWithLeftView:(UIViewController *)leftVC
                     andMainView:(UIViewController *)mainVC{
    if(self = [super init]){
        _speedf = ANIMATION_SPEED;
        self.leftVC = leftVC;
        self.mainVC = mainVC;
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
        //3D旋转
//        _mainVC.view.transformUnit = 2.5;
//        [_mainVC.view prepareForTransform3D];
        [_mainVC.view addGestureRecognizer:_pan];
        [_pan setCancelsTouchesInView:YES];
        _pan.delegate = self;
        
        if ([UIDevice currentDevice].systemVersion.integerValue >= 7.0) {
            _mainVC.view.frame = CGRectMake(0, 40 - BAR_HEIGHT, kScreenWidth, kScreenHeight - BAR_HEIGHT);
        }else{
            _mainVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight -20);
        }
//        [self showImageAndReflection:_mainVC.view.layer];
        _leftVC.view.hidden = YES;
        [self.view addSubview:_leftVC.view];
        
        UIView *view = [[UIView alloc] init];
        view.frame = _leftVC.view.frame;
        view.backgroundColor = [UIColor blackColor];
        //改变背景颜色
//        view.backgroundColor = [UIColor whiteColor];
//        self.view.backgroundColor = [UIColor whiteColor];
        view.alpha = 0.8;
        _contentView = view;
        [self.view addSubview:view];
        
        for (UIView *obj in _leftVC.view.subviews) {
            if ([obj isKindOfClass:[UITableView class]]) {
                _leftTableview = (UITableView *)obj;
            }
        }
        
        _leftVC.view.transform = CGAffineTransformMakeScale(kLeftScale, kLeftScale);
        _leftVC.view.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        _leftTableview.frame = CGRectMake(10,kScreenHeight/2, kScreenWidth - kMainPageDistance - 5, kScreenHeight * 2/3 + 15);
        _leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        [self.view addSubview:_mainVC.view];
        _closed = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCurrentViewForSharePoint:) name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _leftVC.view.hidden = NO;
}

-(void)handlePan: (UIPanGestureRecognizer *)rec{
    if (_closed && [rec translationInView:self.mainVC.view].x > 0 && [rec velocityInView:self.mainVC.view].x > SUDO && [rec locationInView:self.mainVC.view].x <= 65) {
        [self openLeftView];
    }else if (!_closed && [rec translationInView:self.mainVC.view].x < 0 && [rec velocityInView:self.mainVC.view].x < -100){
        [self closeLeftView];
    }
}

//-(void)handlePan: (UIPanGestureRecognizer *)rec{
//    CGPoint locaPoint = [rec locationInView:self.view];
//    CGPoint transPoint = [rec translationInView:self.view];
//    CGPoint vePoint = [rec velocityInView:self.view];
//    NSLog(@"~~~%f++++%f,,,,,%f",locaPoint.x,transPoint.x,vePoint.x);
//    CGFloat movePercent = 1 - locaPoint.x/self.view.frame.size.width;
//    
//    if (locaPoint.x < 0 || movePercent <= 0.5) {
//        return;
//    }
//    
//    if (UIGestureRecognizerStateBegan == rec.state) {
//
//    }else if (UIGestureRecognizerStateChanged == rec.state ) {
//        if (transPoint.x>0) {
//            [_mainVC.view setCenter:CGPointMake(_mainVC.view.center.x + transPoint.x/2, _mainVC.view.center.y)];
//            [_mainVC.view setTransform3DWithPanTranslation:locaPoint];
//            _leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
//            _leftVC.view.center = CGPointMake(CGRectGetMidX(_leftVC.view.frame) + transPoint.x,SCREEN_WIDTH/2);
//            _leftTableview.center = _leftVC.view.center;
//            _contentView.alpha = movePercent;
//        }else if (transPoint.x <0){
//            [self closeLeftView];
//        }
//    }else if (UIGestureRecognizerStateEnded == rec.state){
//        //判断位置
//        if (locaPoint.x >= SCREEN_WIDTH*1/4 && _closed) {
//            [self openLeftView];
//        }else if (locaPoint.x <= SCREEN_WIDTH/4 && !_closed){
////            [self closeLeftView];
//        }
//    }
//    [rec setTranslation:CGPointZero inView:rec.view];
//}

-(void)handeTap:(UITapGestureRecognizer *)tap{
    if ((!_closed) && (tap.state == UIGestureRecognizerStateEnded)){
        [UIView animateWithDuration:_speedf animations:^{
            tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//            CGFloat fHeight ;
//            if (CURRENT_VERSION <7.0) {
//                fHeight = -10;
//            }else fHeight = 10;
//            
            CGFloat l;
            CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height;
            if (40 == y) {
                l = -40;
                self.view.y = 20;
            }else{
                self.view.y = 0;
            }
            
//            tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2 + fHeight + l);
            
            tap.view.frame = CGRectMake(0, BAR_HEIGHT + l, kScreenWidth, kScreenHeight - BAR_HEIGHT);
            _closed = YES;
            _leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kLeftScale, kLeftScale);
            _leftVC.view.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
            _leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
            _contentView.alpha = kLeftAlpha;
        } completion:^(BOOL finished) {
            [self removeSingleTap];
        }];
    }
}

- (void)closeLeftView
{
    [UIView animateWithDuration:_speedf animations:^{
        _mainVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
//        CGFloat fHeight ;
//        if (CURRENT_VERSION <7.0) {
//            fHeight = -10;
//        }else fHeight = 10;
//        
        CGFloat l;
        CGFloat y = [UIApplication sharedApplication].statusBarFrame.size.height;
        if (40 == y) {
            l = -40;
            self.view.y = 20;
        }else{
            self.view.y = 0;
        }
        
//      _mainVC.view.center = CGPointMake(kScreenWidth/2, kScreenHeight/2 + fHeight + l);
        
        _mainVC.view.frame = CGRectMake(0, BAR_HEIGHT + l, kScreenWidth, kScreenHeight - BAR_HEIGHT);
        _closed = YES;
        _leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, kLeftScale, kLeftScale);
        _leftVC.view.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        _leftTableview.center = CGPointMake(kLeftCenterX, kScreenHeight * 0.5);
        _contentView.alpha = kLeftAlpha;
        
        
//         NSLog(@"~~~~~~坐标：%f,高度:%f",_mainVC.view.y,_mainVC.view.height);
    } completion:^(BOOL finished) {
        [self removeSingleTap];
    }];
}

- (void)openLeftView{
    [UIView animateWithDuration:_speedf animations:^{
        CALayer *layer = _mainVC.view.layer;
        CATransform3D transform1 = CATransform3DMakeScale(.55, .6, .1);
        CATransform3D transform2 = CATransform3DIdentity;
        transform2.m34 = -1.0 / 600.0;
        transform2 = CATransform3DRotate(transform2, -0.35, 0, 1, 0);
        layer.transform = CATransform3DConcat(transform2, transform1);
        layer.position = CGPointMake(self.view.width* 4/6 + 20, self.view.height /2 - 10);
        layer.zPosition = 10.0f;
        
        _closed = NO;
        _leftVC.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        
        CGFloat height;
        if (40 == BAR_HEIGHT) {
            height = 40;
        }
        _leftVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - height/2);
//        _leftVC.view.center = CGPointMake(kScreenWidth/2,kScreenHeight/2);
        
        _leftTableview.center = CGPointMake((kScreenWidth - kMainPageDistance) * 0.5 + 3, kScreenHeight * 0.5  - 15);
        _contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self disableTapButton];
    }];
}


- (void)disableTapButton{
    for (UIButton *tempButton in [_mainVC.view subviews]){
        [tempButton setUserInteractionEnabled:NO];
    }
    if (!_sideslipTapGes){
        _sideslipTapGes= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
        [_sideslipTapGes setNumberOfTapsRequired:1];
        [_mainVC.view addGestureRecognizer:_sideslipTapGes];
    }
}

- (void) removeSingleTap{
    for (UIButton *tempButton in [self.mainVC.view  subviews]){
        [tempButton setUserInteractionEnabled:YES];
    }
    [_mainVC.view removeGestureRecognizer:_sideslipTapGes];
    _sideslipTapGes = nil;
    
    if([_leftVC isKindOfClass:[LLeftView class]]){
//        [(aReuLeftViewController*)_leftVC clearAllSectionValue];
    }
}

- (void)setPanEnabled: (BOOL) enabled{
    [_pan setEnabled:enabled];
}

- (void)showImageAndReflection:(CALayer*)layer{
    UIGraphicsBeginImageContext(_mainVC.view.size);
    [_mainVC.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CALayer *reflectLayer = [CALayer layer];
    reflectLayer.contents = (id)[viewImage CGImage];
//    reflectLayer.backgroundColor = [UIColor blackColor].CGColor;
    reflectLayer.bounds = CGRectMake(0, 0, layer.bounds.size.width, layer.bounds.size.height/12);
    
    CGFloat hfloat = reflectLayer.bounds.size.height/2;
    reflectLayer.position = CGPointMake(layer.bounds.size.width/2,  layer.bounds.size.height + hfloat);
    reflectLayer.transform = CATransform3DMakeRotation(M_PI,1,0,0);
    
    CALayer *blackLayer = [CALayer layer];
    blackLayer.backgroundColor = [UIColor grayColor].CGColor;
    blackLayer.bounds = reflectLayer.bounds;
    blackLayer.position = CGPointMake(blackLayer.bounds.size.width/2, blackLayer.bounds.size.height/2);
    blackLayer.opacity = 0.3;
    [reflectLayer addSublayer:blackLayer];
    
    CAGradientLayer *mask = [CAGradientLayer layer];
    mask.bounds = reflectLayer.bounds;
    mask.position = CGPointMake(mask.bounds.size.width/2, mask.bounds.size.height/2);
    mask.colors = [NSArray arrayWithObjects:
                   (__bridge id)[UIColor clearColor].CGColor,
                   (__bridge id)[UIColor whiteColor].CGColor, nil];
    mask.startPoint = CGPointMake(0.5, 0.6);
    mask.endPoint = CGPointMake(0.5, 1.0);
    reflectLayer.mask = mask;
    
    [layer addSublayer:reflectLayer];
    [self.view.layer addSublayer:layer];
}



@end
