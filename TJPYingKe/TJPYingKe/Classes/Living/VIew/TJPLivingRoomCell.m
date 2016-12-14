//
//  TJPLivingRoomCell.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/14.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPLivingRoomCell.h"

@implementation TJPLivingRoomCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

#pragma mark - lazy



#pragma mark - setter
- (void)setLiveItem:(TJPHotLiveItem *)liveItem
{
    _liveItem = liveItem;
}



@end
