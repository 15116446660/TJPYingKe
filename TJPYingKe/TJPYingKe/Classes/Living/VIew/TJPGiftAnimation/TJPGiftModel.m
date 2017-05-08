//
//  TJPGiftModel.m
//  TestAnimation
//
//  Created by Walkman on 2017/3/2.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "TJPGiftModel.h"

@implementation TJPGiftModel

- (instancetype)initWithSenderName:(NSString *)senderName senderIcon:(NSString *)senderIcon giftIcon:(NSString *)giftIcon giftName:(NSString *)giftName {
    if (self = [super init]) {
        _senderName = senderName;
        _senderIcon = senderIcon;
        _giftIcon = giftIcon;
        _giftName = giftName;
    }
    return self;
}

//重写系统的isEqual方法 用来判断
- (BOOL)isEqual:(id)object {
    //将object转成model
    if (![object isKindOfClass:[TJPGiftModel class]]) {
        return NO;
    }
    TJPGiftModel *model = (TJPGiftModel *)object;
    //比较礼物和用户
    if ([model.senderName isEqualToString:_senderName] && [model.giftName isEqualToString:_giftName]) {
        return YES;
    }
    
    return NO;
}



@end
