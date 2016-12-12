//
//  TJPPicScrollView.h
//  TJPPicScrollView
//
//  Created by Walkman on 2016/12/8.
//  Copyright © 2016年 tangjiapeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJPAdPicProtocol.h"

typedef void(^LoadImageBlock)(UIImageView *imageView, NSURL *url);

@protocol TJPPicScrollViewDelegate <NSObject>

- (void)adPicViewDidSelectedPicModel: (id <TJPAdPicProtocol>)picModel;


@end

@interface TJPPicScrollView : UIView

/** 实例对象*/
+ (instancetype)picViewWithLoadImageBlock:(LoadImageBlock)loadBlock;


/** 用于加载图片的代码块*/
@property (nonatomic, copy) LoadImageBlock loadBlock;


/**  用来展示图片的数据源*/
@property (nonatomic, strong) NSArray <id <TJPAdPicProtocol>>*picModels;


/**  用于告知外界, 当前滚动到的是哪个广告数据模型*/
@property (nonatomic, assign) id<TJPPicScrollViewDelegate> delegate;

/** 控制页坐标X 默认为0*/
@property (nonatomic, assign) CGFloat pageControlX;








@end
