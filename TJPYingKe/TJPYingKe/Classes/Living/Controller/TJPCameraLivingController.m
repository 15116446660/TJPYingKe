//
//  TJPCameraLivingController.m
//  TJPYingKe
//
//  Created by Walkman on 2017/3/31.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "TJPCameraLivingController.h"

@interface TJPCameraLivingController ()

@end

@implementation TJPCameraLivingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
