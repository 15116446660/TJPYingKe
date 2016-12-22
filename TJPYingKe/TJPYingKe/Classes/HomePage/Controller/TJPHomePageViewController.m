//
//  TJPHomePageViewController.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/7.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPHomePageViewController.h"
#import <TJPSengment/TJPSegementBarVC.h>
#import "TJPAttentionViewController.h"
#import "TJPHotViewController.h"
#import "TJPNearByViewController.h"
#import "TJPTalentViewController.h"

@interface TJPHomePageViewController ()

@property (nonatomic, weak) TJPSegementBarVC *segementBarVC;


@end

@implementation TJPHomePageViewController


#pragma mark - lazy
- (TJPSegementBarVC *)segementBarVC
{
    if (!_segementBarVC) {
        TJPSegementBarVC *vc = [[TJPSegementBarVC alloc] init];
        [self addChildViewController:vc];
        _segementBarVC = vc;
    }
    return _segementBarVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];

    
    [self setupNavigationTitleView];
    
    [self setupNavigationItem];

    

    

}

- (void)setupNavigationTitleView {
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.segementBarVC.segementBar.frame = CGRectMake(0, 0, 265, 35);
    self.navigationItem.titleView = self.segementBarVC.segementBar;

    self.segementBarVC.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight + 64);
    [self.view addSubview:self.segementBarVC.view];
    
    TJPAttentionViewController *attentionVC = [[TJPAttentionViewController alloc] init];
    TJPHotViewController *hotVC = [[TJPHotViewController alloc] init];
    
    TJPNearByViewController *nearbyVC = [[TJPNearByViewController alloc] init];
    
    TJPTalentViewController *talentVC = [[TJPTalentViewController alloc] init];
    
    [self.segementBarVC setUpWithItems:@[@"关注", @"热门", @"附近", @"才艺"] childVCs:@[attentionVC, hotVC, nearbyVC, talentVC]];
    
    //设置属性相关
    [self.segementBarVC.segementBar updateWithConfig:^(TJPSegementBarConfig *config) {
        config.segementBarBackColor = [UIColor clearColor];
        config.itemNormalColor = [UIColor whiteColor];
        config.itemSelectedColor = [UIColor whiteColor];
        
        config.indicatorColor = [UIColor whiteColor];
        config.indicatorExtraW = -10;
        
    }];
}



- (void)setupNavigationItem {
    
    //left item
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"title_button_search" highImage:@"title_button_search" target:self andAction:@selector(search)];
    //right item
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"title_button_more" highImage:@"title_button_more" target:self andAction:@selector(more)];

    
    
}

#pragma mark - 方法实现
- (void)search {
    
    TJPLogFunc
}

- (void)more {
    
    TJPLogFunc
    
}






















@end
