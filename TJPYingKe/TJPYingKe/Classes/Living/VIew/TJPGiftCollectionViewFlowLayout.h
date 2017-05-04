//
//  TJPGiftCollectionViewFlowLayout.h
//  TJPYingKe
//
//  Created by AaronTang on 2017/5/4.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TJPGiftCollectionViewFlowLayout : UICollectionViewFlowLayout

//  一行中 cell 的个数
@property (nonatomic,assign) NSUInteger itemCountPerRow;

//    一页显示多少行
@property (nonatomic,assign) NSUInteger rowCount;

@end
