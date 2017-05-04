//
//  TJPGiftView.h
//  TJPYingKe
//
//  Created by AaronTang on 2017/5/3.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TJPGiftItem;
@interface TJPGiftView : UIView


/** 礼物数据*/
@property (nonatomic, strong) NSMutableArray <TJPGiftItem *>*giftData;
/** 选择礼物回调*/
@property (nonatomic, copy) void(^sendGiftBlock)(NSString *username, NSString *giftName, NSString *giftIcon);

/** instancetype*/
+ (instancetype)giftViewWithFrame:(CGRect)frame;


/** 展示礼物列表*/
- (void)actionSheetViewShow;
/** 隐藏*/
- (void)tappedCancel;

@end
