//
//  TJPUserHelper.h
//  TJPYingKe
//
//  Created by Walkman on 2017/3/20.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TJPUserHelper : NSObject

+ (instancetype)sharedUser;

/** 是否登录*/
+ (BOOL)isLogin;
/** 存储登录信息*/
+ (void)saveLoginMark:(BOOL)value;

@end
