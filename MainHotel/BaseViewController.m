//
//  BaseViewController.m
//  WeiBo
//
//  Created by iMac on 15-9-14.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseViewController.h"


#define NavItemButtonHW 20

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //兼容性问题
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        //self.edgesForExtendedLayout = UIRectEdgeNone;
        
        //self.extendedLayoutIncludesOpaqueBars = NO;
        
        //self.modalPresentationCapturesStatusBarAppearance = NO;
        
        //self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
#endif
    
    //添加滑动手势,导航视图中返回上一级
//    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureAct:)];
//    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;//从左向右的手势
//    [self.view addGestureRecognizer:swipeGesture];
    
}

//平移手势
- (void)swipeGestureAct:(UISwipeGestureRecognizer *)swipe{
    
    
    //状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //返回按钮
    [self.navigationController popViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
