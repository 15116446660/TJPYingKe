//
//  TJPLivingRoomController.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/14.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPLivingRoomController.h"
#import "TJPNavigationController.h"
#import "TJPLiveRoomFlowLayout.h"
#import "TJPLivingRoomCell.h"
#import "TJPUserView.h"



@interface TJPLivingRoomController ()

@property (nonatomic, weak) TJPUserView *userView;





@end

@implementation TJPLivingRoomController

static NSString * const CellID = @"TJPLiveRoomCell";


- (instancetype)init
{
    return [super initWithCollectionViewLayout:[[TJPLiveRoomFlowLayout alloc] init]];
}


#pragma mark - lazy
- (TJPUserView *)userView {
    if (!_userView) {
        TJPUserView *userView = [TJPUserView userView];
        userView.hidden = YES;
        userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [self.view addSubview:userView];
        _userView = userView;
        WS(weakSelf)
        [userView setCloseViewBlock:^{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.userView.hidden = YES;
                weakSelf.userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:nil];
        }];
        
    }
    return _userView;
}




#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    TJPNavigationController *nav = (TJPNavigationController *)self.navigationController;
    [nav setupBackPanGestureIsForbiddden:YES];

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[TJPLivingRoomCell class] forCellWithReuseIdentifier:CellID];
    //添加通知
    [self addObserve];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TJPLivingRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.parentVc = self;
    cell.liveItem = self.liveDatas[self.currentIndex];
    
    return cell;
}



#pragma mark - 通知相关
- (void)addObserve {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickUser:) name:kNotificationClickUser object:nil];
    
}


- (void)clickUser:(NSNotification *)notification {
    
    if (notification.userInfo[@"info"]) {
        TJPLiveRoomTopUserItem *userItem = notification.userInfo[@"info"];
        self.userView.userItem = userItem;
        [UIView animateWithDuration:0.25 animations:^{
            self.userView.hidden = NO;
            self.userView.transform = CGAffineTransformIdentity;
        }];
        
    }
    
}









- (void)removeObserve {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 布局
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.offset(302);
        make.height.offset(410);
    }];
}

 

- (void)dealloc {
    [self removeObserve];
}




@end
