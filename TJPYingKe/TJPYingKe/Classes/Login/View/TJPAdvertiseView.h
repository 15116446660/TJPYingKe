//
//  TJPAdvertiseView.h
//  TJPYingKe
//
//  Created by Walkman on 2017/3/20.
//  Copyright © 2017年 AaronTang. All rights reserved.
//  广告视图

#import <UIKit/UIKit.h>

typedef enum  {
    TJPAdvertiseViewTypeUnknow = 0,
    TJPAdvertiseViewTypeFullScreen,
    TJPAdvertiseViewTypeLogo
}TJPAdvertiseViewType;

typedef void(^TJPAdvertiseViewClick)(NSString *link);

@interface TJPAdvertiseView : UIView
/** 本地图片 用于没有网路图片时显示*/
@property (nonatomic, copy) NSString *localImageName;
/** 点击回调*/
@property (nonatomic, copy) TJPAdvertiseViewClick clickBlock;


/** 初始化方法*/
+ (instancetype)TJPAdvertiseViewWithType:(TJPAdvertiseViewType)type;

/** 显示广告*/
- (void)advertiseShow;
/** 清除广告图片缓存*/
- (void)cleanAdvertiseImageCache;

@end
