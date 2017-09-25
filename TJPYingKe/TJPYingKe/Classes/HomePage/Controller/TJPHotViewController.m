//
//  TJPHotViewController.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/8.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPHotViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>

#import "UIViewController+Loading.h"


#import "TJPLivingRoomController.h"
#import "TJPWebViewController.h"
#import "TJPRefreshGifHeader.h"
#import "TJPHotLiveItemCell.h"
#import "TJPCreatorItem.h"
#import "TJPBannerItem.h"


static NSString * const cellID              = @"liveListCell";
static CGFloat const timeInterval           = 80;


@interface TJPHotViewController ()


/** 数据源*/
@property (nonatomic, strong) NSMutableArray *liveDatas;
@property (nonatomic, strong) NSArray <TJPBannerItem *>*bannerArr;

@property (nonatomic, weak) NSTimer *timer;


@end

@implementation TJPHotViewController


#pragma mark - lazy
- (NSMutableArray *)liveDatas
{
    if (!_liveDatas) {
        _liveDatas = [NSMutableArray array];
    }
    return _liveDatas;
}

- (NSArray<TJPBannerItem *> *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [NSArray array];
    }
    return _bannerArr;
}

- (NSTimer *)timer {
    if (!_timer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(loadNewDataForHotPage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}


#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setTabBarHidden:NO];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    //UI
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"TJPHotLiveItemCell" bundle:nil] forCellReuseIdentifier:cellID];
    //数据
    [self loadDataForBannerView];
    //刷新
    [self addRefresh];
    //定时器
    [self timer];
}




#pragma mark - Data
- (void)loadDataForBannerView {
    [self showLoadingView];
    WS(weakSelf)
    NSMutableArray *tmpImageArr = [NSMutableArray array];
    //顶部轮播图数据
    [[TJPRequestDataTool shareInstance] getTopCarouselModels:^(NSArray<TJPBannerItem *> *carouselModels) {
        for (TJPBannerItem *item in carouselModels) {
            if (![item.image hasPrefix:@"http://"]) {
                item.image = [NSString stringWithFormat:@"%@%@", kTJPCommonServiceAPI, item.image];
            }
            [tmpImageArr addObject:item.image];
        }
        weakSelf.bannerArr = carouselModels;
        weakSelf.tableView.tableHeaderView =  [weakSelf setupHeaderView:tmpImageArr];
    }];
    [self loadDataForHotLive];
}

//热门数据
- (void)loadDataForHotLive {
    WS(weakSelf)
    [[TJPRequestDataTool shareInstance] getHotPageModelsWithTableView:self.tableView result:^(NSMutableArray<TJPHotLiveItem *> *hotModels) {
        [self hideLoadingView];
        weakSelf.liveDatas = hotModels;
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - refresh
- (void)addRefresh {
    //下拉刷新
    WS(weakSelf)
    TJPRefreshGifHeader *header = [TJPRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    self.tableView.mj_header = header;
}

//定时器方法
- (void)loadNewDataForHotPage {
    TJPLog(@"timer触发"); 
    [self loadNewData];
}

//获取新数据
- (void)loadNewData {
    [self loadDataForHotLive];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _liveDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJPHotLiveItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJPLivingRoomController *roomVC = [[TJPLivingRoomController alloc] init];
    roomVC.liveDatas = [NSArray arrayWithArray:self.liveDatas];
    roomVC.currentIndex = indexPath.row;
    [self.navigationController pushViewController:roomVC animated:YES];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kScreenHeight * 0.644;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJPHotLiveItemCell * liveCell = (TJPHotLiveItemCell *)cell;
    TJPHotLiveItem *item = [_liveDatas objectAtIndexChecked:indexPath.row];
    liveCell.liveItem = item;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //scrollView已经有拖拽手势，直接拿到scrollView的拖拽手势
    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    //获取到拖拽的速度 >0 向下拖动 <0 向上拖动
    CGFloat velocity = [pan velocityInView:scrollView].y;
    
    if (velocity < -5) {
        //向上拖动，隐藏导航栏
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self setTabBarHidden:YES];
    }else if (velocity > 5) {
        //向下拖动，显示导航栏
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self setTabBarHidden:NO];
    }
}


#pragma mark - privite
- (void)setTabBarHidden:(BOOL)hidden
{
    UIView *tab = self.tabBarController.view;
    CGRect tabRect = self.tabBarController.tabBar.frame;
    if ([tab.subviews count] < 2) {
        return;
    }
    
    UIView *view;
    if ([[tab.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]]) {
        view = [tab.subviews objectAtIndex:1];
    } else {
        view = [tab.subviews objectAtIndex:0];
    }
    
    if (hidden) {
        view.frame = tab.bounds;
        tabRect.origin.y = kScreenHeight + self.tabBarController.tabBar.tjp_height;
    } else {
        view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
        tabRect.origin.y = kScreenHeight - self.tabBarController.tabBar.tjp_height;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
}


- (UIView *)setupHeaderView:(NSArray *)itemImageUrlStrs {
    WS(weakSelf)
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.225) imageNamesGroup:itemImageUrlStrs];
    cycleScrollView.placeholderImage = [UIImage imageNamed:@"default_ticker"];
    cycleScrollView.autoScrollTimeInterval = 3.f;
    cycleScrollView.pageDotColor = [UIColor colorWithWhite:1.0 alpha:0.7];
    cycleScrollView.currentPageDotColor = kGlobalLightBlueColor;
    [cycleScrollView setClickItemOperationBlock:^(NSInteger index) {
        TJPBannerItem *item = weakSelf.bannerArr[index];
        TJPWebViewController *webVC = [[TJPWebViewController alloc] init];
        webVC.urlStr = item.link;
        [weakSelf.navigationController pushViewController:webVC animated:YES];
    }];
    
    return cycleScrollView;
}



@end
