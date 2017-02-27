//
//  TJPRequestDataTool.m
//  TJPYingKe
//
//  Created by Walkman on 2017/2/27.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "TJPRequestDataTool.h"
#import "TJPRefreshGifHeader.h"




@interface TJPRequestDataTool ()

@property (nonatomic, strong) TJPSessionManager *sessionManager;


@end


static TJPRequestDataTool *dataTool = nil;

@implementation TJPRequestDataTool
- (TJPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[TJPSessionManager alloc] init];
    }
    return _sessionManager;
}


+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataTool = [[TJPRequestDataTool alloc] init];
    });
    return dataTool;
}



- (void)getHotPageModelsWithTableView:(UITableView *)tableView  result:(void(^)(NSMutableArray <TJPHotLiveItem *>*hotModels))resultBlock {
    [self.sessionManager request:RequestTypeGet urlStr:HOT_LIVE_URL parameter:nil resultBlock:^(id responseObject, NSError *error) {
        [tableView.mj_header endRefreshing];
        if (error) {
            TJPLog(@"%@", error.localizedDescription);
            return;
        }
        NSMutableArray <TJPHotLiveItem *>*hotModels = [TJPHotLiveItem mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        resultBlock(hotModels);
    }];

}

/** 获取直播间用户数据*/
- (void)getLivingRoomTopUserModelsWithLiveID:(NSUInteger)liveID  result:(void(^)(NSMutableArray <TJPLiveRoomTopUserItem *>*topUserModels))resultBlock {
    
    NSString *url = [NSString stringWithFormat:@"%@%lu&s_sg=c2681fa2c3c60a48e6de037e84df86f9&s_sc=100&s_st=1481858627", LiveRoomTopUser_URL, liveID];
     TJPLog(@"%@", url);
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:nil resultBlock:^(id responseObject, NSError *error) {
        if (error) {
            TJPLog(@"%@", error.localizedDescription);
            return;
        }
        NSMutableArray *topUserModels = [TJPLiveRoomTopUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"users"]];
        resultBlock(topUserModels);
    }];
}



@end
