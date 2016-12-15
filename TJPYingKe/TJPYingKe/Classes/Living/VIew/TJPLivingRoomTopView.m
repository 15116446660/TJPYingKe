//
//  TJPLivingRoomTopView.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/15.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPLivingRoomTopView.h"
#import <Masonry/Masonry.h>


static CGFloat BgViewH = 34;
static CGFloat AttentionBtnH = 23;
static CGFloat TicketBgViewH = 23;
static CGFloat ScrollViewMargin = 20;



#define CblowViewColor                  [UIColor colorWithWhite:0.0 alpha:0.2]


@interface TJPLivingRoomTopView()

@property (nonatomic, weak) UIView *hostBgView; //256*64
/** 头像*/
@property (nonatomic, weak) UIImageView *headImageView;
/** 直播*/
@property (nonatomic, weak) UILabel *liveLab;
/** 直播数量*/
@property (nonatomic, weak) UILabel *liveCountLab;
/** 关注按钮*/
@property (nonatomic, weak) UIButton *attentionBtn;


/** */
@property (nonatomic, weak) UIView *ticketBgView; //240*46
/** 映票ImageView*/
@property (nonatomic, weak) UIImageView *ticketImageView;
/** 映票文字*/
@property (nonatomic, weak) UILabel *ticketCountLabel;
@property (nonatomic, weak) UIImageView *rightImageView;

/** 头像滚动视图*/
@property (nonatomic, weak) UIScrollView *headImageScrollView;
/** 映客号*/
@property (nonatomic, weak) UILabel *yingKeNumLab;
/** 日期*/
@property (nonatomic, weak) UILabel *dateLabel;







@end

@implementation TJPLivingRoomTopView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}




- (void)layoutSubviews {
    
    [super layoutSubviews];
    WS(weakSelf)
    [self.hostBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(128, BgViewH));
        make.top.offset(5);
        make.left.offset(10);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(32, 32));
        make.left.and.top.offset(1);
    }];
    
    [self.liveLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(4);
        make.left.equalTo(weakSelf.headImageView.mas_right).offset(10);
        
    }];
    
    [self.liveCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.liveLab.mas_bottom).offset(3);
        make.left.equalTo(weakSelf.headImageView.mas_right).offset(10);
    }];
    
//    [self.attentionBtn sizeToFit];
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, AttentionBtnH));
        make.top.offset(5);
        make.right.offset(-6);
    }];
    
    [self.ticketBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(120, TicketBgViewH));
        make.height.offset(TicketBgViewH);
        make.width.greaterThanOrEqualTo(@120);//设置最小宽度
        make.top.equalTo(weakSelf.hostBgView.mas_bottom).offset(7);
        make.left.mas_equalTo(weakSelf.hostBgView);
    }];
    [self.ticketImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.left.offset(9);
    }];
    [self.ticketCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(2);
        make.left.equalTo(weakSelf.ticketImageView.mas_right).offset(1);
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(6);
        make.left.equalTo(weakSelf.ticketCountLabel.mas_right).offset(5);
    }];
    
    //更新父视图宽度
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont fontWithName:@"Georgia" size:15.f]};
    CGSize size=[_ticketCountLabel.text sizeWithAttributes:attrs];
    CGFloat viewW = _ticketImageView.tjp_width + size.width + _rightImageView.tjp_width + DefaultMargin * 2;
    [self.ticketBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(viewW);
    }];
    
    [self layoutIfNeeded]; //必须手动刷新才能拿到frame

    //头像滚动视图
    [self.headImageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.hostBgView);
        make.left.equalTo(weakSelf.hostBgView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - weakSelf.hostBgView.tjp_width - ScrollViewMargin, BgViewH));
    }];
    
    
    
    
}

#pragma mark - lazy
- (UIView *)hostBgView {
    if (!_hostBgView) {
        UIView *hostBgView = [[UIView alloc] init];
        hostBgView.backgroundColor = CblowViewColor;
        hostBgView.layer.cornerRadius = BgViewH * 0.5;
        hostBgView.clipsToBounds = YES;
        [self addSubview:hostBgView];
        _hostBgView = hostBgView;
    }
    return _hostBgView;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        UIImageView *headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"default_head"]];
        [self.hostBgView addSubview:headImageView];
        _headImageView = headImageView;
    }
    return _headImageView;
}

- (UILabel *)liveLab {
    if (!_liveLab) {
        UILabel *liveLab = [[UILabel alloc] init];
        liveLab.text = @"直播";
        liveLab.textColor = [UIColor whiteColor];
        liveLab.font = [UIFont systemFontOfSize:10.f];
        [self.hostBgView addSubview:liveLab];
        _liveLab = liveLab;
    }
    return _liveLab;
}

- (UILabel *)liveCountLab {
    if (!_liveCountLab) {
        UILabel *liveCountLab = [[UILabel alloc] init];
        liveCountLab.text = @"99999";
        liveCountLab.textColor = [UIColor whiteColor];
        liveCountLab.font = [UIFont systemFontOfSize:10.f];
        [self.hostBgView addSubview:liveCountLab];
        _liveCountLab = liveCountLab;
    }
    return _liveCountLab;
}

- (UIButton *)attentionBtn {
    if (!_attentionBtn) {
        UIButton *attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [attentionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        attentionBtn.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [attentionBtn setBackgroundColor:TJPColor(48, 221, 209)];
        attentionBtn.layer.cornerRadius = AttentionBtnH * 0.5;
        attentionBtn.clipsToBounds = YES;
        //        [attentionBtn setImage:[UIImage imageNamed:@"live_guanzhu_"] forState:UIControlStateNormal];
        [self.hostBgView addSubview:attentionBtn];
        _attentionBtn = attentionBtn;
    }
    return _attentionBtn;
}

- (UIView *)ticketBgView {

    if (!_ticketBgView) {
        UIView *ticketBgView = [[UIView alloc] init];
        ticketBgView.backgroundColor = CblowViewColor;
        ticketBgView.layer.cornerRadius = TicketBgViewH * 0.5;
        ticketBgView.clipsToBounds = YES;
        [self addSubview:ticketBgView];
        _ticketBgView = ticketBgView;
    }
    return _ticketBgView;
}

- (UIImageView *)ticketImageView {
    if (!_ticketImageView) {
        UIImageView *ticketImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_yp_icon1-1_"]];
        [ticketImageView sizeToFit];
        [self.ticketBgView addSubview:ticketImageView];
        _ticketImageView = ticketImageView;
    }
    return _ticketImageView;
}

- (UILabel *)ticketCountLabel {
    if (!_ticketCountLabel) {
        UILabel *ticketCountLabel = [[UILabel alloc] init];
        ticketCountLabel.text = @"123456789";
        [ticketCountLabel setFont:[UIFont fontWithName:@"Georgia" size:15.f]];
        ticketCountLabel.textColor = [UIColor whiteColor];
        [self.ticketBgView addSubview:ticketCountLabel];
        _ticketCountLabel = ticketCountLabel;
        
    }
    return _ticketCountLabel;
}
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_yp_btn_n_"]];
        [rightImageView sizeToFit];
        [self.ticketBgView addSubview:rightImageView];
        _rightImageView = rightImageView;
    }
    return _rightImageView;
}

- (UIScrollView *)headImageScrollView {
    if (!_headImageScrollView) {
        UIScrollView *headScrollView = [[UIScrollView alloc] init];
        headScrollView.showsVerticalScrollIndicator = NO;
        headScrollView.showsHorizontalScrollIndicator = NO;
        headScrollView.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:headScrollView];
        _headImageScrollView = headScrollView;
    }
    return _headImageScrollView;
}


- (UILabel *)yingKeNumLab {
    if (!_yingKeNumLab) {
//        UILabel *yingKeLab = [[UILabel alloc] init];
        
    }
    return _yingKeNumLab;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        
    }
    return _dateLabel;
}










@end
