//
//  TJPLivingRoomController.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/14.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPLivingRoomController.h"
#import "TJPLiveRoomFlowLayout.h"
#import "TJPNavigationController.h"
#import "TJPLivingRoomCell.h"


@interface TJPLivingRoomController ()

@end

@implementation TJPLivingRoomController

static NSString * const CellID = @"TJPLiveRoomCell";


- (instancetype)init
{
    return [super initWithCollectionViewLayout:[[TJPLiveRoomFlowLayout alloc] init]];
}


#pragma mark - lazy





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

@end
