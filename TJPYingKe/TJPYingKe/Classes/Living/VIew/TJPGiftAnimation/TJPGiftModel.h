//
//  TJPGiftModel.h
//  TestAnimation
//
//  Created by Walkman on 2017/3/2.
//  Copyright © 2017年 AaronTang. All rights reserved.
//  礼物model

#import <Foundation/Foundation.h>

@interface TJPGiftModel : NSObject
@property (nonatomic, copy) NSString *senderName;
@property (nonatomic, copy) NSString *senderIcon;
@property (nonatomic, copy) NSString *giftIcon;
@property (nonatomic, copy) NSString *giftName;



- (instancetype)initWithSenderName:(NSString *)senderName senderIcon:(NSString *)senderIcon giftIcon:(NSString *)giftIcon giftName:(NSString *)giftName;


@end
