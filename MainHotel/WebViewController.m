//
//  WebViewController.m
//  MainHotel
//
//  Created by iMac on 15-10-14.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "WebViewController.h"

#define NavButtonHW 30

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpMainView];
    
}


- (void)setUpMainView{
    
    //1.隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    
    //2.创建webview
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KIPHONEWidth, KIPHONEHeight)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    _webView.backgroundColor = [UIColor whiteColor];
    
    //2.1使用链接
    NSURL *url = [NSURL URLWithString:self.contentUrl];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [_webView loadRequest:urlRequest];
    
    [self hudProgressLoading];
    
    //3.导航图标
    UIButton *navButton = [[UIButton alloc] initWithFrame:CGRectZero];
    navButton.frame = CGRectMake(XMargin*2, XMargin*5, NavButtonHW, NavButtonHW);
    [navButton setImage:[UIImage imageNamed:@"btn_back~iphone"] forState:UIControlStateNormal];
    [navButton addTarget:self action:@selector(navigationClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:navButton];
    
    //分享按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(20, KIPHONEHeight - 50, 25, 25);
    shareButton.backgroundColor = [UIColor whiteColor];
    [shareButton setImage:[UIImage imageNamed:@"btn_share~iphone"] forState:UIControlStateNormal];
    shareButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [shareButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    shareButton.layer.cornerRadius = 25/2;
    shareButton.layer.masksToBounds = YES;
}

//分享按钮
- (void)buttonClick{
    
    if (!_shareView) {
        _shareView = [[ShareView alloc] initWithView:self.navigationController.view];
        
        [self.navigationController.view addSubview:_shareView];
    }else{
        [_shareView shareViewAnimation];
        [self.navigationController.view addSubview:_shareView];
    }
    
}


//导航按钮点击事件
- (void)navigationClick:(UIButton *)btn{
    //1.显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //返回按钮
    [self.navigationController popViewControllerAnimated:YES];
}


//加载进度
- (void)hudProgressLoading{
    
    if (_HUD == nil) {
        
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        _HUD.labelText = @"加载中";
        _HUD.color = [UIColor clearColor];
        _HUD.labelColor = [UIColor blackColor];
        _HUD.activityIndicatorColor = [UIColor blackColor];
    }
    [_HUD show:YES];
    
}


#pragma mark -- webview代理
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //隐藏加载视图
    [_HUD hide:YES];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = [request.URL absoluteString];//获取url地址转位字符串
    NSLog(@"%@",urlString);
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
