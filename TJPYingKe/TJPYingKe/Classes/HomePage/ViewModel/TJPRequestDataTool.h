//
//  TJPRequestDataTool.h
//  TJPYingKe
//
//  Created by Walkman on 2017/2/27.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJPLiveRoomTopUserItem.h"
#import "TJPNavigationTagItem.h"
#import "TJPAdvertiseModel.h"
#import "TJPHotLiveItem.h"
#import "TJPBannerItem.h"
#import "TJPGiftItem.h"



@interface TJPRequestDataTool : NSObject

+ (instancetype)shareInstance;

/** 导航栏标签数据*/
- (void)getNavigationTagModels:(void(^)(NSArray <TJPNavigationTagItem *>*tagModels))resultBlock;

/** 广告页数据 */
- (void)getAdvertiseModel:(void(^)(TJPAdvertiseModel *model))resultBlock;

/** 轮播数据*/
- (void)getTopCarouselModels:(void(^)(NSArray <TJPBannerItem *>*carouselModels))resultBlock;


/** 获取热门数据*/
- (void)getHotPageModelsWithTableView:(UITableView *)tableView  result:(void(^)(NSMutableArray <TJPHotLiveItem *>*hotModels))resultBlock;


/** 获取直播间用户数据*/
- (void)getLivingRoomTopUserModelsWithLiveID:(NSUInteger)liveID  result:(void(^)(NSMutableArray <TJPLiveRoomTopUserItem *>*topUserModels))resultBlock;

/** 礼物数据*/
- (void)getLivingRoomGiftModels:(void(^)(NSMutableArray <TJPGiftItem *>*giftModels))resultBlock;

@end
