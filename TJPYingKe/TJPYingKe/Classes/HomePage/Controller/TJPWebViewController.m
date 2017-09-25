//
//  TJPWebViewController.m
//  TJPYingKe
//
//  Created by Walkman on 2017/3/3.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "TJPWebViewController.h"
#import <WebKit/WebKit.h>

#import "TJPWebProgressLayer.h"

static NSString *const estimatedProgress = @"estimatedProgress";

@interface TJPWebViewController ()

@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, weak) TJPWebProgressLayer *progressLayer;


@end

@implementation TJPWebViewController

- (WKWebView *)webView {
    if (!_webView) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        [webView addObserver:self forKeyPath:estimatedProgress options:NSKeyValueObservingOptionNew context:nil];
        [self.view addSubview:webView];
        _webView = webView;
    }
    return _webView;
}

- (TJPWebProgressLayer *)progressLayer {
    if (!_progressLayer) {
        TJPWebProgressLayer *progressLayer = [TJPWebProgressLayer new];
        progressLayer.frame = CGRectMake(0, -1, kScreenWidth, 2);
        progressLayer.progressColor = [UIColor redColor];
        [self.view.layer addSublayer:progressLayer];
        _progressLayer = progressLayer;
    }
    return _progressLayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]]];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _webView.frame = self.view.bounds;
}




#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:estimatedProgress]) {
        //防止进度条倒走  有时goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        
        [self.progressLayer startLoadWithProgress:[change[@"new"] floatValue]];
        
        if ([change[@"new"] floatValue] == 1) {

            [self.progressLayer finishedLoadWhenProgressEnd];
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];

    }
    
    

}


- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:estimatedProgress];
}

@end
