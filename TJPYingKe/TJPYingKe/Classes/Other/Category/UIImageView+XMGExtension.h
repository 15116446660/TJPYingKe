//
//  UIImageView+XMGExtension.h
//  百思不得姐
//
//  Created by 王顺子 on 16/6/16.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TJPBlurredImageCompletionBlock)();

extern CGFloat const kTJPBlurredImageDefaultBlurRadius;



@interface UIImageView (XMGExtension)

- (void)setURLImageWithURL: (NSURL *)url progress:(void(^)(CGFloat progress))progress complete: (void(^)())complete;

- (void)setURLImageWithURL: (NSURL *)url placeHoldImage:(UIImage *)placeHoldImage isCircle:(BOOL)isCircle;


/**
 根据模糊程度来处理图片

 @param image 要处理的图片
 @param blurRadius 模糊度
 @param completion 处理完成的block
 */
- (void)setImageToBlur:(UIImage *)image blurRadius:(CGFloat)blurRadius completionBlock:(TJPBlurredImageCompletionBlock)completion;


/**
 图片模糊效果处理

 @param image 要处理的图片
 @param completion 处理完成的block
 */
- (void)setImageToBlur:(UIImage *)image
       completionBlock:(TJPBlurredImageCompletionBlock)completion;

@end
