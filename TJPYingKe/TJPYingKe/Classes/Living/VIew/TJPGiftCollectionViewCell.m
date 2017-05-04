//
//  TJPGiftCollectionViewCell.m
//  TJPYingKe
//
//  Created by AaronTang on 2017/5/4.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "TJPGiftCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "TJPGiftItem.h"


@interface TJPGiftCollectionViewCell ()

@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UIImageView *giftImageView;


@end

@implementation TJPGiftCollectionViewCell

- (UILabel *)titleLab {
    if (!_titleLab) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, _giftImageView.tjp_bottom + kDefaultMargin, self.tjp_width - 30, 15)];
//        titleLab.backgroundColor = TJPColor(170, 170, 170);
        titleLab.textColor = [UIColor whiteColor];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:titleLab];
        self.titleLab = titleLab;
    }
    return _titleLab;
}

- (UIImageView *)giftImageView {
    if (!_giftImageView) {
        UIImageView *giftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tjp_width * 0.5, self.tjp_height * 0.5)];
        giftImageView.center = CGPointMake(self.center.x, self.center.y - 10);
        [self.contentView addSubview:giftImageView];
        _giftImageView = giftImageView;
    }
    return _giftImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    [self giftImageView];
    [self titleLab];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置collectionView cell的边框
//    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = TJPColor(255, 202, 0).CGColor;
    self.layer.masksToBounds = YES;
}


- (void)setGiftItem:(TJPGiftItem *)giftItem {
    _giftItem = giftItem;

    NSString *urlStr;
    if ([giftItem.image hasPrefix:@"http://"]) {
        urlStr = giftItem.image;
    }else {
        urlStr = [NSString stringWithFormat:@"%@%@", kTJPCommonServiceAPI, giftItem.image];
    }
    TJPLog(@"%@", urlStr);
    [_giftImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    _titleLab.text = giftItem.name;
}







@end
