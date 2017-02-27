//
//  TJPHotViewController.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/8.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPHotViewController.h"
#import "TJPLivingRoomController.h"
#import "TJPRefreshGifHeader.h"
#import "TJPHotLiveItemCell.h"
#import "TJPCreatorItem.h"
#import "TJPRequestDataTool.h"


static NSString * const cellID = @"liveListCell";


@interface TJPHotViewController ()


/** 数据源*/
@property (nonatomic, strong) NSMutableArray *liveDatas;

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

- (NSTimer *)timer {
    if (!_timer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:90 target:self selector:@selector(loadNewDataForHotPage) userInfo:nil repeats:YES];
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
    [self loadData];
    //刷新
    [self addRefresh];
    //定时器
    [self timer];
}




#pragma mark - Data
- (void)loadData {
    WS(weakSelf)
    [[TJPRequestDataTool shareInstance] getHotPageModelsWithTableView:self.tableView result:^(NSMutableArray<TJPHotLiveItem *> *hotModels) {
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
    [self.liveDatas removeAllObjects];
    [self loadData];
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _liveDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TJPHotLiveItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[TJPHotLiveItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TJPHotLiveItem *item = _liveDatas[indexPath.row];
    cell.liveItem = item;
    
    
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
    }else if(velocity == 0){
        //停止拖拽
    }
}



//隐藏显示tabbar
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
        tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height+self.tabBarController.tabBar.frame.size.height;
    } else {
        view.frame = CGRectMake(tab.bounds.origin.x, tab.bounds.origin.y, tab.bounds.size.width, tab.bounds.size.height);
        tabRect.origin.y = [[UIScreen mainScreen] bounds].size.height-self.tabBarController.tabBar.frame.size.height;
    }
    
    [UIView animateWithDuration:0.25f animations:^{
        self.tabBarController.tabBar.frame = tabRect;
    }completion:^(BOOL finished) {
        
    }];
    
}









@end
