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
#define kScreenWidth                        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                       [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight                    20
#define kDefaultMargin                      10
#define kNavigationBarHeight                64



/**    颜色     **/
#define TJPColorA(r, g, b, a)               [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define TJPColor(r, g, b)                   TJPColorA((r), (g), (b), 1.0)

#define kGlobalLightBlueColor               TJPColorA(0, 216, 201, 1)


/**    通知     **/
#define kNotificationClickUser              @"kNotificationClickUser"     //点击用户






#endif /* PublicHeader_h */
