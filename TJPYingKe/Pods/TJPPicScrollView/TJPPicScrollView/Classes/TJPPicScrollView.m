    //
//  TJPPicScrollView.m
//  TJPPicScrollView
//
//  Created by Walkman on 2016/12/8.
//  Copyright © 2016年 tangjiapeng. All rights reserved.
//

#import "TJPPicScrollView.h"

static NSInteger const radio = 10;


@interface TJPPicScrollView()<UIScrollViewDelegate>
{
    NSInteger _currentPage;
}

/** 记录着根据模型数组, 添加的imageView控件*/
@property (nonatomic, strong) NSMutableArray <UIImageView *>*picsArr;

/** 存放图片的内容视图*/
@property (nonatomic, weak) UIScrollView *contentView;
/**  页码指示*/
@property (nonatomic, weak) UIPageControl *pageControl;

/** 自动滚动的timer*/
@property (nonatomic, weak) NSTimer *scrollTimer;




@end

@implementation TJPPicScrollView


+ (instancetype)picViewWithLoadImageBlock:(LoadImageBlock)loadBlock {

    TJPPicScrollView *picScrollView = [[TJPPicScrollView alloc] init];
    picScrollView.loadBlock = loadBlock;
    
    return picScrollView;
}


- (NSTimer *)scrollTimer
{
    if (!_scrollTimer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(scrollNextPage) userInfo:nil repeats:YES];
        //让NSRunLoop管理timer
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _scrollTimer = timer;
    }
    return _scrollTimer;
}

- (void)scrollNextPage {
    NSInteger page = _currentPage + 1;
    [self.contentView setContentOffset:CGPointMake(self.contentView.frame.size.width * page, 0) animated:YES];
}


- (UIScrollView *)contentView
{
    if (!_contentView) {
        UIScrollView *contentView = [[UIScrollView alloc] init];
        contentView.pagingEnabled = YES;
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.delegate = self;
        [self addSubview:contentView];
        _contentView = contentView;
    }
    return _contentView;
}



- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.hidesForSinglePage = YES;
        [self addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (NSMutableArray<UIImageView *> *)picsArr
{
    if (!_picsArr) {
        _picsArr = [NSMutableArray array];
    }
    return _picsArr;
}




- (void)setPicModels:(NSArray<id<TJPAdPicProtocol>> *)picModels {
    
    _picModels = picModels;
    
    //1.移除之前控件
    [self.picsArr makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.picsArr = nil;
    
    //2.根据模型添加新控件
    NSInteger baseCount = picModels.count;
    NSInteger count = baseCount;
    if (baseCount > 1) {
        count = baseCount * radio;
    }
    
    for (int i = 0; i < count; i++) {
        
        id<TJPAdPicProtocol> picM = picModels[i % baseCount];
        
        // 1. 创建控件
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.tag = self.picsArr.count;
        
        // 2. 设置图片(SDWebImage)
        if (self.loadBlock) {
            self.loadBlock(imageView, picM.adImgURL);
        }
        
        // 3. 添加手势, 点击图片跳转
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToLink:)];
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:tap];
        
        // 4. 添加到父控件, 以及使用数组保存
        [self.contentView addSubview:imageView];
        [self.picsArr addObject:imageView];

    }
    
    self.pageControl.numberOfPages = picModels.count;
    
    [self setNeedsLayout];
    
    if (picModels.count > 1) {
        [self.scrollTimer fire];
    }else {
        [self.scrollTimer invalidate];
        self.scrollTimer = nil;
    }
}

/** 点击跳转方法*/
- (void)jumpToLink:(UITapGestureRecognizer *)gester {
    
    UIView *imageView = gester.view;
    NSInteger tag = imageView.tag % self.picModels.count;
    id<TJPAdPicProtocol> adM = self.picModels[tag];
    
    
    if (adM.clickBlock) {
        adM.clickBlock();
    }
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(self.pageControlX, self.frame.size.height - 20, self.frame.size.width - self.pageControlX, 20);

    
    NSInteger count = self.picsArr.count;
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    for(int i = 0;i < count;i++) {
        UIImageView *imageView = self.picsArr[i];
        imageView.frame = CGRectMake(i * width, 0, width, height);
        
    }
    
    self.contentView.contentSize = CGSizeMake(width * count, 0);
    [self scrollViewDidEndDecelerating:self.contentView];
    
    
}


#pragma mark - UISCrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.picsArr.count > 1) {
        [self scrollTimer];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self caculateCurrentPage:scrollView];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self caculateCurrentPage:scrollView];
    
}


- (void)caculateCurrentPage: (UIScrollView *)scrollView {
    
    //如果数据源里没数据
    if (!self.picModels.count) {
        return;
    }
    if (self.picModels.count == 1) {
        _currentPage = 1;
        if ([self.delegate respondsToSelector:@selector(adPicViewDidSelectedPicModel:)]) {
            [self.delegate adPicViewDidSelectedPicModel:self.picModels[self.pageControl.currentPage]];
        }
        return;
    }
    
    // 确认中间区域
    NSInteger min = self.picModels.count * (radio / 2);
    NSInteger max = self.picModels.count * (radio / 2 + 1);
    
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.pageControl.currentPage = page % self.picModels.count;
    
    if (page < min || page > max) {
        page = min + page % self.picModels.count;
        [scrollView setContentOffset:CGPointMake(page * scrollView.frame.size.width, 0)];
    }
    
    _currentPage = page;
    
    if ([self.delegate respondsToSelector:@selector(adPicViewDidSelectedPicModel:)]) {
        [self.delegate adPicViewDidSelectedPicModel:self.picModels[self.pageControl.currentPage]];
    }


}




@end
