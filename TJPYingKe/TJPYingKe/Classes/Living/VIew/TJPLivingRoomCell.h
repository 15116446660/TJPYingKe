//
//  TJPLivingRoomCell.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/14.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TJPHotLiveItem.h"
#import "TJPLivingRoomTopView.h"

@interface TJPLivingRoomCell : UICollectionViewCell

/** model*/
@property (nonatomic, strong) TJPHotLiveItem *liveItem;

/** 父控制器*/
@property (nonatomic, weak) UIViewController *parentVc;


@end
