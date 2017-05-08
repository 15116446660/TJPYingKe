//
//  TJPCountLabel.h
//  TestAnimation
//
//  Created by Walkman on 2017/3/1.
//  Copyright © 2017年 AaronTang. All rights reserved.
//  连击文字label

#import <UIKit/UIKit.h>

@interface TJPCountLabel : UILabel

/** 开始动画*/
- (void)startAnimation:(void(^)())complection;


@end
