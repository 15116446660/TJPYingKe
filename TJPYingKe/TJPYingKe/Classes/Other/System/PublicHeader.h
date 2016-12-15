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
#define DefaultMargin               10


/**    接口     **/
#define HOT_LIVE_URL                @"http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1"


/**    颜色     **/
#define TJPColorA(r, g, b, a)                                       [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]
#define TJPColor(r, g, b)                                           TJPColorA((r), (g), (b), 255)




#endif /* PublicHeader_h */
