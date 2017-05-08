//
//  TJPGiftContainerView.h
//  TestAnimation
//
//  Created by Walkman on 2017/3/2.
//  Copyright © 2017年 AaronTang. All rights reserved.
//  栈道容器视图

#import <UIKit/UIKit.h>
@class TJPGiftModel;
@interface TJPGiftContainerView : UIView

/** 添加礼物*/
- (void)addGift:(TJPGiftModel *)giftModel;

@end
