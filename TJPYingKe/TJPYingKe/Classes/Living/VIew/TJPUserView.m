//
//  TJPUserView.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/16.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "TJPUserView.h"

@implementation TJPUserView

+ (instancetype)userView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib {
    
    [super awakeFromNib];

}




@end
