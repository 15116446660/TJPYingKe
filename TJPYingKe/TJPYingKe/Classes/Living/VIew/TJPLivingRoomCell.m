//
//  TJPLivingRoomCell.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/14.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPLivingRoomCell.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import "UIImageView+XMGExtension.h"
#import "TJPLivingRoomBottomView.h"
#import "TJPLiveRoomTopUserItem.h"
#import "TJPLivingRoomTopView.h"
#import "DMHeartFlyView.h"
#import "TJPCreatorItem.h"




@interface TJPLivingRoomCell()
{
    NSString *_flv;
}


/** 直播开始前的占位图片*/
@property(nonatomic, weak) UIImageView *placeHolderView;

/** 顶部view*/
@property (nonatomic, weak) TJPLivingRoomTopView *topView;
/** 底部view*/
@property(nonatomic, weak) TJPLivingRoomBottomView *bottomView;

@property (nonatomic, weak) DMHeartFlyView *heartView;


/** 直播播放器*/
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
/** 播放器属性*/
@property (nonatomic, strong) IJKFFOptions *options;

/** 粒子动画*/
@property(nonatomic, weak) CAEmitterLayer *emitterLayer;

@property (nonatomic, strong) TJPSessionManager *sessionManager;





@end

@implementation TJPLivingRoomCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

#pragma mark - lazy

- (TJPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[TJPSessionManager alloc] init];
    }
    return _sessionManager;
}


- (IJKFFOptions *)options {
    if (!_options) {
        IJKFFOptions *options = [IJKFFOptions optionsByDefault];
        [options setPlayerOptionIntValue:1  forKey:@"videotoolbox"];
        // 帧速率(fps) 非标准桢率会导致音画不同步，所以只能设定为15或者29.97
        [options setPlayerOptionIntValue:29.97 forKey:@"r"];
        // 置音量大小，256为标准  要设置成两倍音量时则输入512，依此类推
        [options setPlayerOptionIntValue:256 forKey:@"vol"];
        _options = options;
    }
    return _options;
}



- (IJKFFMoviePlayerController *)moviePlayer {
    
    if (!_moviePlayer) {
        IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:_flv withOptions:self.options];
        // 填充fill
        moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
        // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
        moviePlayer.shouldAutoplay = NO;
        // 默认不显示
        moviePlayer.shouldShowHudView = NO;
        [moviePlayer prepareToPlay];
        
        _moviePlayer = moviePlayer;
    }
    return _moviePlayer;
}

- (CAEmitterLayer *)emitterLayer {
    if (!_emitterLayer) {
        CAEmitterLayer *emitterLayer = [CAEmitterLayer layer];
        //发射器在xy平面的中心位置
        emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.tjp_width - 50, self.moviePlayer.view.tjp_height - 50);
        //发射器尺寸
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        //渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered;
        
        NSMutableArray <CAEmitterCell *>*emitterCellArr = [NSMutableArray array];
        //创建粒子
        for (int i = 0; i < 10; i++) {
            //发射单元
            CAEmitterCell *cell = [CAEmitterCell emitterCell];
            //粒子速率 默认1/s
            cell.birthRate = 1;
            //粒子存活时间
            cell.lifetime = arc4random_uniform(4) + 1;
            //粒子生存时间容差
            cell.lifetimeRange = 1.5;
            //粒子显示内容
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30", i]];
            cell.contents = (__bridge id _Nullable)(([image CGImage]));
            //粒子运动速度
            cell.velocity = arc4random_uniform(100) + 100;
            //粒子运动速度容差
            cell.velocityRange = 80;
            //粒子在xy平面的发射角度
            cell.emissionLongitude = M_PI + M_PI_2;
            //发射角度容差
            cell.emissionRange = M_PI_2 / 6;
            //缩放比例
            cell.scale = 0.3;
            [emitterCellArr addObject:cell];
        }
        
        emitterLayer.emitterCells = emitterCellArr;
        [self.moviePlayer.view.layer addSublayer:emitterLayer];
        _emitterLayer = emitterLayer;
    }
    return _emitterLayer;
}


- (UIImageView *)placeHolderView {
    if (!_placeHolderView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        _placeHolderView = imageView;
    }
    return _placeHolderView;
}

- (TJPLivingRoomBottomView *)bottomView {
    if (!_bottomView) {
        TJPLivingRoomBottomView *bottomView = [TJPLivingRoomBottomView bottomView];
        bottomView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bottomView];
        _bottomView = bottomView;
    }
    return _bottomView;
    
}

- (TJPLivingRoomTopView *)topView {
    if (!_topView) {
        TJPLivingRoomTopView *topView = [[TJPLivingRoomTopView alloc] initWithFrame:CGRectZero];
        topView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:topView];
        _topView = topView;
    }
    return _topView;
}



#pragma mark - setter
- (void)setLiveItem:(TJPHotLiveItem *)liveItem
{
    _liveItem = liveItem;
    self.topView.liveItem = liveItem;
    [self loadDataForTopUser];
    
    NSURL *imageUrl;
    if ([liveItem.creator.portrait hasPrefix:@"http://"]) {
        imageUrl = [NSURL URLWithString:liveItem.creator.portrait];
    }else {
        imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",liveItem.creator.portrait]];
    }
    
    [self playWithFLV:liveItem.stream_addr placeHolderUrl:imageUrl];

}


- (void)loadDataForTopUser {
    
    NSString *url = [NSString stringWithFormat:@"%@%lu&s_sg=c2681fa2c3c60a48e6de037e84df86f9&s_sc=100&s_st=1481858627", LiveRoomTopUser_URL, _liveItem.ID];
    [self.sessionManager request:RequestTypeGet urlStr:url parameter:nil resultBlock:^(id responseObject, NSError *error) {
        
        if (error) {
            TJPLog(@"%@", error.localizedDescription);
            return;
        }
        NSMutableArray *array = [TJPLiveRoomTopUserItem mj_objectArrayWithKeyValuesArray:responseObject[@"users"]];
        _topView.topUsers = array;
    }];
    
}




#pragma mark - method
- (void)playWithFLV:(NSString *)flv placeHolderUrl:(NSURL *)placeHolderUrl {

    _flv = flv;
    if (_moviePlayer) {
        if (_moviePlayer) {
            [self.contentView insertSubview:self.placeHolderView aboveSubview:_moviePlayer.view];
        }
                [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
        [self removeMovieNotificationObservers];
    }
    
    // 如果有粒子动画,先移除
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
        _emitterLayer = nil;
    }
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:placeHolderUrl options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.placeHolderView setImageToBlur:image completionBlock:nil];
        });
    }];
    
    
    [self.contentView insertSubview:self.moviePlayer.view atIndex:0];
    
    
    //添加监听
    [self addObserveForMoviePlayer];
    
    //创建顶部视图
    [self setupTopView];
    
    //创建底部视图
    [self setupBottomView];

}

- (void)setupTopView {
    
    self.topView.backgroundColor = [UIColor clearColor];
    

}



- (void)setupBottomView {
    WS(weakSelf)
    [self.bottomView setButtonClickedBlock:^(LivingRoomBottomViewButtonClickType clickType, UIButton *button) {
        switch (clickType) {
            case LivingRoomBottomViewButtonClickTypeChat:
            {
                TJPLog(@"chat");
            }
                break;
            case LivingRoomBottomViewButtonClickTypeMessage:
            {
                TJPLog(@"Message");
                
            }
                break;
            case LivingRoomBottomViewButtonClickTypeGift:
            {
                TJPLog(@"gift");
                
            }
                break;
            case LivingRoomBottomViewButtonClickTypeShare:
            {
                TJPLog(@"share");
                //点击出心
//                CGFloat _heartSize = 36;
//                DMHeartFlyView *heart = [[DMHeartFlyView alloc] initWithFrame:CGRectMake(button.frame.origin.x, kScreenHeight - self.bottomView.tjp_height, _heartSize, _heartSize)];
//                [self.contentView addSubview:heart];
//                _heartView = heart;
//                [heart animateInView:self.contentView];
                
                
            }
                break;
            case LivingRoomBottomViewButtonClickTypeBack:
            {
                TJPLog(@"back");
                [weakSelf playStop];
                
            }
                break;
                
            default:
                break;
        }
    }];
    
}




//返回,停播
- (void)playStop
{
    // 停播
    if (_moviePlayer) {
        [self.moviePlayer shutdown];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    //移除粒子动画
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
        _emitterLayer = nil;
    }
    //移除心形动画
    if (_heartView) {
        [_heartView removeFromSuperview];
    }
    [self.parentVc.navigationController popViewControllerAnimated:YES];
}



#pragma mark - layoutSubviews
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.moviePlayer.view.frame = self.contentView.bounds;
    self.placeHolderView.frame = self.contentView.bounds;
    self.topView.frame = CGRectMake(0, kStatusBarHeight, kScreenWidth, 80);
    self.bottomView.frame = CGRectMake(0, kScreenHeight - 54, kScreenWidth, 44);
    
}



#pragma mark - Notification
- (void)addObserveForMoviePlayer {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_moviePlayer];

}


//notification method emplemtation
- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _moviePlayer.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) { //shouldAutoplay 为yes 在这种状态下会自动开始播放
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
            //粒子动画开始
            [self.emitterLayer setHidden:NO];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_placeHolderView) {
                    [_placeHolderView removeFromSuperview];
                    _placeHolderView = nil;
                }
            });
        }
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) { //如果正在播放,会在此状态下暂停
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification { //播放结束时,或者是用户退出时会触发
    
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {//播放状态改变时,会触发
    
    switch (_moviePlayer.playbackState) {
            
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_moviePlayer.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward: {
        
        }
            break;
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_moviePlayer.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_moviePlayer.playbackState);
            break;
        }
    }
}



#pragma mark - 释放相关
- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_moviePlayer];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_moviePlayer];
    
}

- (void)dealloc {
    TJPLog(@"dealloc方法被调用");
    [self removeMovieNotificationObservers];
    
}



@end
