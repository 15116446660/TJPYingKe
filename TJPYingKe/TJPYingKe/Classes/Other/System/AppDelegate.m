//
//  AppDelegate.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/6.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "AppDelegate.h"
#import "TJPHomePageViewController.h"
#import "TJPLoginViewController.h"
#import "TJPMineViewController.h"
#import "TJPTabBarController.h"
#import "TJPAdvertiseView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置按钮的排他性
    [[UIButton appearance] setExclusiveTouch:YES];

    
    if (![TJPUserHelper isLogin]) {
        [self loginViewControllerShow];
    }else {
        [self homePageViewControllerShow];
    }

    [self.window makeKeyAndVisible];
    
    //广告
    TJPAdvertiseView *advertiseView = [TJPAdvertiseView TJPAdvertiseViewWithType:TJPAdvertiseViewTypeLogo];
    advertiseView.localImageName = @"defaultAd.jpg";
    [self.window addSubview:advertiseView];
    [advertiseView cleanAdvertiseImageCache];
    [advertiseView advertiseShow];
    advertiseView.clickBlock = ^(NSString *link) {
        TJPLog(@"广告链接:%@", link);
    };
    return YES;
}

/** 主页*/
- (void)homePageViewControllerShow {
    TJPTabBarController *rootVC = [TJPTabBarController tabBarControllerWitnAddChildVCBlock:^(TJPTabBarController *tabBarVC) {
        [tabBarVC addChildVC:[[TJPHomePageViewController alloc] init] normalImageName:@"tab_live" selectedImageName:@"tab_live_p" isRequiredNavController:YES];
        [tabBarVC addChildVC:[[TJPMineViewController alloc] init] normalImageName:@"tab_me" selectedImageName:@"tab_me_p" isRequiredNavController:YES];
    }];
    
    self.window.rootViewController = rootVC;
}

/** 登录*/
- (void)loginViewControllerShow {
    TJPLoginViewController *loginVC = [TJPLoginViewController new];
    self.window.rootViewController = loginVC;
}






@end
