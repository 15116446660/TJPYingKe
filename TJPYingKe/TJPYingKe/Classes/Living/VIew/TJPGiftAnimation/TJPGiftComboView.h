//
//  TJPGiftChanneView.h
//  TestAnimation
//
//  Created by Walkman on 2017/3/1.
//  Copyright © 2017年 AaronTang. All rights reserved.
//  连击动画视图

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TJPGiftComboViewState) {
    TJPGiftComboViewStateUnknown = 0,
    TJPGiftComboViewStateIdle,                                      //闲置
    TJPGiftComboViewStateAnimating,                                 //正在执行动画
    TJPGiftComboViewStateWaiting,                                   //等待动画结束
    TJPGiftComboViewStateEnding                                     //结束
};

@class TJPGiftModel;
@interface TJPGiftComboView : UIView

@property (nonatomic, assign) TJPGiftComboViewState state;          //状态

@property (nonatomic, strong) TJPGiftModel *giftModel;              //礼物模型

@property (nonatomic, assign) NSInteger cacheNum;                   //缓存数量(用来检查是否连续送)

@property (nonatomic, copy) void(^animationFinishedCompletion)(TJPGiftComboView *comboView);                                                     //动画完成回调

/** 加载xib*/
+ (TJPGiftComboView *)loadGiftComboView;

/** 添加缓存*/
- (void)addOnceAnimationToCache;

@end
