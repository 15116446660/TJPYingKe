//
//  TJPLivingRoomController.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/14.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPLivingRoomController.h"
#import "TJPNavigationController.h"

@interface TJPLivingRoomController ()

@end

@implementation TJPLivingRoomController


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
}
@end
