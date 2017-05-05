//
//  TJPUserHelper.m
//  TJPYingKe
//
//  Created by Walkman on 2017/3/20.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "TJPUserHelper.h"

@implementation TJPUserHelper

static TJPUserHelper *user = nil;
+ (instancetype)sharedUser {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[TJPUserHelper alloc] init];
    });
    return user;
}

/** 是否登录*/
+ (BOOL)isLogin {
    return [UserDefaults boolForKey:User_Login];
}
/** 存储登录信息*/
+ (void)saveLoginMark:(BOOL)value {
    [UserDefaults setBool:value forKey:User_Login];
}

/** 用户头像*/
+ (NSString *)userHeadImage {
    return @"userHeader.jpg";
}

@end
