//
//  TJPAdPicProtocol.h
//  TJPPicScrollView
//
//  Created by Walkman on 2016/12/9.
//  Copyright © 2016年 tangjiapeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TJPAdPicProtocol <NSObject>

/** 广告图片URL*/
@property (nonatomic, copy, readonly) NSURL *adImgURL;


/**  点击执行的代码块(优先级高于adLinkURL)*/
@property (nonatomic, copy) void(^clickBlock)();

@end
