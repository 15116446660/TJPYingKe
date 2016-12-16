//
//  TJPUserView.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/16.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJPLiveRoomTopUserItem;
@interface TJPUserView : UIView


+ (instancetype)userView;

@property (nonatomic, strong) TJPLiveRoomTopUserItem *userItem;


@property (nonatomic, copy) void(^closeViewBlock)();



@end
