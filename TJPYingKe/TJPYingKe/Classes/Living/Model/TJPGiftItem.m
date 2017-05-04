//
//  TJPGiftItem.m
//  TJPYingKe
//
//  Created by AaronTang on 2017/5/4.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "TJPGiftItem.h"

@implementation TJPGiftItem
//解决关键字冲突
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}


@end
