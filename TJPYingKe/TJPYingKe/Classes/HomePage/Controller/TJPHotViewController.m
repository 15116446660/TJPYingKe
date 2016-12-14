//
//  TJPHotViewController.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/8.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPHotViewController.h"
#import "TJPLivingRoomController.h"
#import "TJPHotLiveItemCell.h"
#import "TJPHotLiveItem.h"
#import "TJPCreatorItem.h"


static NSString * const cellID = @"liveListCell";


@interface TJPHotViewController ()
@property (nonatomic, strong) TJPSessionManager *sessionManager;

/** 数据源*/
@property (nonatomic, strong) NSMutableArray *liveDatas;



@end

@implementation TJPHotViewController


#pragma mark - lazy
- (TJPSessionManager *)sessionManager {
    if (!_sessionManager) {
        _sessionManager = [[TJPSessionManager alloc] init];
    }
    return _sessionManager;
}

- (NSMutableArray *)liveDatas
{
    if (!_liveDatas) {
        _liveDatas = [NSMutableArray array];
    }
    return _liveDatas;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self loadData];
    
    self.tableView.separatorColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"TJPHotLiveItemCell" bundle:nil] forCellReuseIdentifier:cellID];

}



#pragma mark - Data
- (void)loadData {
    
    [self.sessionManager request:RequestTypeGet urlStr:HOT_LIVE_URL parameter:nil resultBlock:^(id responseObject, NSError *error) {
        
        if (error) {
            TJPLog(@"%@", error.localizedDescription);
            return;
        }
        
        _liveDatas = [TJPHotLiveItem mj_objectArrayWithKeyValuesArray:responseObject[@"lives"]];
        
        TJPLog(@"%@", _liveDatas);
        
        [self.tableView reloadData];
        
    }];
    
    
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




@end
