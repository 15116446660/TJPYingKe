//
//  TJPAdvertiseView.h
//  TJPYingKe
//
//  Created by Walkman on 2017/3/20.
//  Copyright © 2017年 AaronTang. All rights reserved.
//  广告视图

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, TJPAdvertiseViewType) {
    TJPAdvertiseViewTypeUnknow = 0,
    TJPAdvertiseViewTypeFullScreen,             //全屏
    TJPAdvertiseViewTypeLogo                    //带Logo
};

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
