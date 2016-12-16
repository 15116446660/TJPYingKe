//
//  TJPLivingRoomTopView.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/15.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TJPHotLiveItem;
@interface TJPLivingRoomTopView : UIView

/** model*/
@property (nonatomic, strong) TJPHotLiveItem *liveItem;
/** 顶部数据*/
@property (nonatomic, strong) NSMutableArray *topUsers;

@property (nonatomic, copy) void(^followBtnClickBlock)(UIButton *button);


@end
