//
//  TJPTabBar.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/7.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPTabBar.h"

@interface TJPTabBar()
@property (nonatomic, weak) UIButton * centerBtn;



@end

@implementation TJPTabBar


#pragma mark - lazy
- (UIButton *)centerBtn {
    if (!_centerBtn) {
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [centerButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [centerButton addTarget:self action:@selector(centerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [centerButton sizeToFit];
        [self addSubview:centerButton];
        _centerBtn = centerButton;
    }
    return _centerBtn;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupInit];
        
    }
    return self;
}

- (void)setupInit {
    //设置样式 取出边线
    self.barStyle = UIBarStyleBlack;
    
    self.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
    
    
}


- (void)centerButtonClicked {
    TJPLog(@"%s", __func__);
    
}

//布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];

    
    NSInteger count = self.items.count;
    
    //确定单个控件大小
    CGFloat buttonW = self.tjp_width / (count + 1);
    CGFloat buttonH = self.tjp_height;
    CGFloat tabBarBtnY = 0;
    
    int tabBarBtnIndex = 0;
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (tabBarBtnIndex == count / 2) {
                tabBarBtnIndex ++;
            }
            
            CGFloat btnX = tabBarBtnIndex * buttonW;
            subView.frame = CGRectMake(btnX, tabBarBtnY, buttonW, buttonH);
            
            tabBarBtnIndex ++;
        }
    }
    
    /****    设置中间按钮frame   ****/
    self.centerBtn.tjp_centerX = self.tjp_width * 0.5;
    self.centerBtn.tjp_y = self.tjp_height - self.centerBtn.tjp_height + 5;

    
}

//设置允许交互的区域     这个方法返回的view为处理事件最合适的view
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (!self.isHidden) {
        //转换坐标到中间按钮
        CGPoint pointInCenterBtn = [self convertPoint:point toView:self.centerBtn];
        //判断
        if ([self.centerBtn pointInside:pointInCenterBtn withEvent:event]) {
            return self.centerBtn;
        }
        return view;
    }
    return view;
    
}





@end
