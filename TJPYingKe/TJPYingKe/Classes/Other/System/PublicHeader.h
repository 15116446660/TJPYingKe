//
//  PublicHeader.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/7.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h


/**    尺寸类    **/
#define kScreenWidth                [UIScreen mainScreen].bounds.size.width
#define kScreenHeight               [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight            20
#define kDefaultMargin              10


/**    接口     **/
#define HOT_LIVE_URL                @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"

#define LiveRoomTopUser_URL         @"http://116.211.167.106/api/live/users?lc=0000000000000043&cc=TG0001&cv=IK3.8.10_Iphone&proto=7&idfa=2D707AF8-980F-415C-B443-6FED3E9BBE97&idfv=76F26589-EA5D-4D0A-BC1C-A4B6010FFA37&devi=135ede19e251cd6512eb6ad4f418fbbde03c9266&osversion=ios_10.100000&ua=iPhone5_2&imei=&imsi=&uid=310474203&sid=209pU5OK49fA6uhxX3taEXIWAm5lENuCrr6xKL48pqAQ0Y0FqL&conn=wifi&mtid=87edd7144bd658132ae544d7c9a0eba8&mtxid=acbc329027f3&logid=110,30,5&start=0&count=20&id="




/**    颜色     **/
#define TJPColorA(r, g, b, a)                                       [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define TJPColor(r, g, b)                                           TJPColorA((r), (g), (b), 255)


/**    通知     **/
#define kNotificationClickUser @"kNotificationClickUser"     //点击用户






#endif /* PublicHeader_h */
