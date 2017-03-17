//
//  TJPHotLiveItemCell.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/9.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPHotLiveItemCell.h"
#import "TJPHotLiveItem.h"
#import "TJPExtraItem.h"
#import "TJPLabelItem.h"
#import "TJPCreatorItem.h"
#import "TJPTagVIew.h"

@interface TJPHotLiveItemCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *lookCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *anchorImageView;
@property (nonatomic, weak) TJPTagVIew *tagView;


@end

@implementation TJPHotLiveItemCell

- (void)setLiveItem:(TJPHotLiveItem *)liveItem
{
    _liveItem = liveItem;
    
    NSURL *imageUrl;
    if ([liveItem.creator.portrait hasPrefix:@"http://"]) {
        imageUrl = [NSURL URLWithString:liveItem.creator.portrait];
    }else {
        imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",liveItem.creator.portrait]];
    }
    
    [self.headImageView setURLImageWithURL:imageUrl placeHoldImage:[UIImage imageNamed:@"default_head"] isCircle:YES];
     
     if (!liveItem.city.length) {
        _addressLabel.text = @"难道在火星?";
    }else{
        _addressLabel.text = [NSString stringWithFormat:@"%@>", liveItem.city];
    }
    
    self.nameLabel.text = liveItem.creator.nick;
    
    [self.anchorImageView setURLImageWithURL:imageUrl placeHoldImage:[UIImage imageNamed:@"default_room"] isCircle:NO];
    self.lookCountLabel.text = [self dealWithOnlineNumber:liveItem.online_users];
//    TJPLog(@"%@", liveItem.extra.label);

    
    NSArray *array = [TJPLabelItem mj_objectArrayWithKeyValuesArray:liveItem.extra.label];
    NSMutableArray *tmpArr = [NSMutableArray array];
    for (TJPLabelItem *item in array) {
        [tmpArr addObject:item.tab_name];
    }
    if (tmpArr.count) {
        self.tagView.tagInfos = tmpArr;
    }
}


- (NSString *)dealWithOnlineNumber:(NSUInteger)number {
    
    NSString *resultStr;
    if (number >= 10000) {
        resultStr = [NSString stringWithFormat:@"%.1f万",
                     number / 10000.0];
    }else if (number >0) {
        resultStr = [NSString stringWithFormat:@"%zd", number];
    }
    return resultStr;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.addressLabel.hidden = YES;
    
    [self tagView];

}


- (void)layoutSubviews {
    [super layoutSubviews];
    
//    _tagView.frame = CGRectMake(self.nameLabel.tjp_x, self.addressLabel.tjp_y, kScreenWidth - self.headImageView.tjp_width - 40, kTagViewHeight);
}



- (TJPTagVIew *)tagView {
    if (!_tagView) {
        CGRect frame =  CGRectMake(self.nameLabel.tjp_x, self.addressLabel.tjp_y, kScreenWidth - self.headImageView.tjp_width - 40, kTagViewHeight);
        TJPTagVIew *tagView = [[TJPTagVIew alloc] initWithFrame:frame];
//        tagView.tagInfos = @[@"清纯", @"可爱可爱", @"性感", @"女神精", @"漂亮大方"];
        [self.contentView addSubview:tagView];
        _tagView = tagView;
    }
    return _tagView;
}



@end
