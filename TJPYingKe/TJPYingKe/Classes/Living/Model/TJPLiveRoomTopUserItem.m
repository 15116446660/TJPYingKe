//
//  TJPLiveRoomTopUserItem.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/16.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPLiveRoomTopUserItem.h"

@implementation TJPLiveRoomTopUserItem


//解决关键字冲突
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Description": @"description",
             @"ID" : @"id"};
}


@end
