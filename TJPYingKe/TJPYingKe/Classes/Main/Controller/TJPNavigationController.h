//
//  TJPNavigationController.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/7.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJPNavigationController : UINavigationController


/**
 全屏返回手势

 @param isForBidden 是否禁止
 */
- (void)setupBackPanGestureIsForbiddden:(BOOL)isForBidden;

@end
