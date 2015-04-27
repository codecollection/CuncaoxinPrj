//
//  MainViewController.m
//  Cuncaoxin
//
//  Created by 刘杰cjs on 15/4/17.
//  Copyright (c) 2015年 com.js.cuncaoxin. All rights reserved.
//

#import "MainViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"
@interface MainViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation MainViewController
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationBarTitle = @"江苏寸草心教育";
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webview.delegate=_progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth, 2)];
    [self.view addSubview:_progressView];

    if (_remoteSpecifiedUrl) {
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_remoteSpecifiedUrl]]];
        
    }else{
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.lkwzs.com/index.php?token=tqgcob1426137232&g=Wap&a=index&m=Index"]]];
    }
    self.leftNavigationBarButtonType = AppNavBarIconTypeBack;
}
- (void)onClickNavgationBarLeftBtn:(UIButton *)btn withNavigationBarBtnType:(NSInteger)navigationBarBtnType{
    //说明此时 是远程推送的url正在显示在第一页
    if (_remoteSpecifiedUrl && ![_webview canGoBack]) {
        
        _remoteSpecifiedUrl = nil;
        [_webview removeFromSuperview];
        _webview = nil;
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 2, kScreenWidth, kScreenHeight-62)];
        [_webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.lkwzs.com/index.php?token=tqgcob1426137232&g=Wap&a=index&m=Index"]]];
        _webview.delegate =_progressProxy;
        [self.view addSubview:_webview];
        
    }else{
        if ([_webview canGoBack]) {
            [_webview goBack];
        }
    }
    
}
#pragma mark ------------------------------------------ NJKWebViewProgressDelegate 代理
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    MyLog(@"webViewD didFailLoadWithError:%@",error);
}

@end
