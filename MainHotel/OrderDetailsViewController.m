//
//  OrderDetailsViewController.m
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "OrderDetailsViewController.h"

@interface OrderDetailsViewController (){
    UILabel *_hostLabel;
    AHReach *_hostReach;
}

@end

@implementation OrderDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.isBackItemShow = YES;
    
    _hostLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 200, 30)];
    [self.view addSubview:_hostLabel];
    _hostLabel.textColor = [UIColor blackColor];
    _hostLabel.backgroundColor = [UIColor cyanColor];
    _hostLabel.text = @"网络连接中...";
    _hostLabel.textAlignment = NSTextAlignmentCenter;
    
    //指定网址
    _hostReach = [AHReach reachForHost:@"baidu.com"];
    [_hostReach startUpdatingWithBlock:^(AHReach *reach) {
        [self updateAvailabilityWithReach:reach];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateAvailabilityWithReach:(AHReach *)reach {
    
    _hostLabel.text = @"目前无网络连接";
    
    if([reach isReachableViaWWAN])
        _hostLabel.text = @"手机网络3G";
    
    if([reach isReachableViaWiFi])
        _hostLabel.text = @"WiFi高品质网络";
}


@end
