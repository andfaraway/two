//
//  AppDelegate.m
//  Two
//
//  Created by ryt on 16/6/27.
//  Copyright © 2016年 ryt. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<UIScrollViewDelegate>
{
    UIPageControl *pageControl;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self loadingGuidePage:[self gitPicArr]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "yqhx.Two" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Two" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Two.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//加载引导页
- (void)loadingGuidePage:(NSArray *)picArr
{
    NSInteger flag = [[NSUserDefaults standardUserDefaults] integerForKey:@"numberOfStarts"];
    NSLog(@"%ld",flag);
    
    if (1) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        //设置滑动scrollView
        UIScrollView *guidePageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, width,height)];
        guidePageScrollView.contentSize = CGSizeMake(width * picArr.count, 0);
        guidePageScrollView.pagingEnabled = YES;
        guidePageScrollView.delegate = self;
        //放上对应的引导图片
        for (NSInteger i=0; i<picArr.count; i++) {
            UIImageView *imageView = [UIImageView new];
            imageView.frame = CGRectMake(width * i, 0, width, height);
            imageView.image = [UIImage imageNamed:[picArr objectAtIndex:i]];
            [guidePageScrollView addSubview:imageView];
            //最后一张放上确认按钮
            if (i == (picArr.count-1)) {
                UIButton *tureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                tureBtn.frame = CGRectMake((width -150)/2, height-100, 150, 50);
                tureBtn.backgroundColor = [UIColor cyanColor];
                [tureBtn setTitle:@"GO" forState:UIControlStateNormal];
                tureBtn.layer.cornerRadius = 5;
                [tureBtn addTarget: self action:@selector(hideGuidePage) forControlEvents:UIControlEventTouchUpInside];
                imageView.userInteractionEnabled = YES;
                [imageView addSubview:tureBtn];
            }
        }
        [self.window.rootViewController.view addSubview:guidePageScrollView];
        flag++;
        [[NSUserDefaults standardUserDefaults]setInteger:flag forKey:@"numberOfStarts"];
        //添加显示页面的点
        pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, height - 50, width, 30)];
        [self.window.rootViewController.view addSubview:pageControl];
        pageControl.numberOfPages = picArr.count;
        pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
}

//隐藏引导页
- (void)hideGuidePage
{
    NSArray *arr = [self.window.rootViewController.view subviews];
    for (UIView *vc in arr) {
        if ([vc isMemberOfClass:[UIScrollView class]] || [vc isMemberOfClass:[UIPageControl class]]) {
            [vc removeFromSuperview];
        }
    }
}

- (NSArray *)gitPicArr
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [arr addObject:[NSString stringWithFormat:@"%d.jpg",i]];
    }
    return arr;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageControl.currentPage = (int)scrollView.contentOffset.x/SCREENWIDTH;
}

@end
