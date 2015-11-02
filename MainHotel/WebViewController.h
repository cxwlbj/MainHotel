//
//  WebViewController.h
//  MainHotel
//
//  Created by iMac on 15-10-14.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "ShareView.h"

@interface WebViewController : BaseViewController<UIWebViewDelegate>{
    UIWebView *_webView;
    MBProgressHUD *_HUD;
    
    ShareView *_shareView;//分享按钮
}

//网页链接
@property (nonatomic,  copy ) NSString *contentUrl;

@end
