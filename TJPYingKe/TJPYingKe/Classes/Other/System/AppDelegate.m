//
//  AppDelegate.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/6.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "AppDelegate.h"
#import "TJPTabBarController.h"
#import "TJPHomePageViewController.h"
#import "TJPMineViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置按钮的排他性
    [[UIButton appearance] setExclusiveTouch:YES];
    
    TJPTabBarController *rootVC = [TJPTabBarController tabBarControllerWitnAddChildVCBlock:^(TJPTabBarController *tabBarVC) {
        [tabBarVC addChildVC:[[TJPHomePageViewController alloc] init] normalImageName:@"tab_live" selectedImageName:@"tab_live_p" isRequiredNavController:YES];
        [tabBarVC addChildVC:[[TJPMineViewController alloc] init] normalImageName:@"tab_me" selectedImageName:@"tab_me_p" isRequiredNavController:YES];
    }];
    
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}



@end
