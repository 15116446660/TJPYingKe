//
//  TJPHotLiveItem.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/9.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TJPCreatorItem;
@interface TJPHotLiveItem : NSObject

/** 直播流地址 */
@property (nonatomic, copy) NSString *stream_addr;
/** 关注人 */
@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** ID号*/
@property (nonatomic, assign) NSUInteger ID;

/** 主播 */
@property (nonatomic, strong)  TJPCreatorItem *creator;
/** 直播间名称*/
@property (nonatomic, copy) NSString *name;




/*
 {
 "creator": {
 "id": 108366579,
 "level": 19,
 "gender": 0,
 "nick": "今非昔比i ",
 "portrait": "http://img2.inke.cn/MTQ4MTUxNTM1NDk4MyM4NDUjanBn.jpg"
 },
 "id": "1481515357617985",
 "name": "陪伴是最长情的告白 ！",
 "city": "",
 "share_addr": "http://mlive18.inke.cn/share/live.html?uid=108366579&liveid=1481515357617985&ctime=1481515357",
 "stream_addr": "http://pull99.a8.com/live/1481515357617985.flv",
 "version": 0,
 "slot": 4,
 "optimal": 0,
 "online_users": 13784,
 "group": 2,
 "link": 0,
 "multi": 0,
 "rotate": 0
 },
 */

@end
