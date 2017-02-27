//
//  TJPRequestDataTool.h
//  TJPYingKe
//
//  Created by Walkman on 2017/2/27.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TJPLiveRoomTopUserItem.h"
#import "TJPHotLiveItem.h"


@interface TJPRequestDataTool : NSObject

+ (instancetype)shareInstance;


/** 获取热门数据*/
- (void)getHotPageModelsWithTableView:(UITableView *)tableView  result:(void(^)(NSMutableArray <TJPHotLiveItem *>*hotModels))resultBlock;


/** 获取直播间用户数据*/
- (void)getLivingRoomTopUserModelsWithLiveID:(NSUInteger)liveID  result:(void(^)(NSMutableArray <TJPLiveRoomTopUserItem *>*topUserModels))resultBlock;

@end
