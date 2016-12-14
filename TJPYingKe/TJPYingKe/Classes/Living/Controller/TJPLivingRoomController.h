//
//  TJPLivingRoomController.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/14.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJPLivingRoomController : UICollectionViewController

/** 直播数据源*/
@property (nonatomic, strong) NSArray *liveDatas;
/** 当前的index*/
@property (nonatomic, assign) NSUInteger currentIndex;

@end
