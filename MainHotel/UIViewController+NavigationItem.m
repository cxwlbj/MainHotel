//
//  UIViewController+NavigationItem.m
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "UIViewController+NavigationItem.h"

@implementation UIViewController (NavigationItem)

@dynamic isBackItemShow;
@dynamic isSetUpItemShow;
@dynamic isNavClarity;

//是否显示返回按钮
- (void)setIsBackItemShow:(BOOL)isBackItemShow{
    //
    if (isBackItemShow == YES) {
        
        //btn_back_default~iphone
        
        UIButton *themeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        themeBtn.frame = CGRectMake(0, 0, 55, 30);
        // 设置背景图片
        [themeBtn setImage:[UIImage imageNamed:@"back_black_icon"] forState:UIControlStateNormal];
        [themeBtn setTitle:@"返回" forState:UIControlStateNormal];
        [themeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        themeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        // 添加事件
        [themeBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:themeBtn];
        
        self.navigationItem.leftBarButtonItem = backBtn;
        
        
    }
    
}

//返回按钮功能
- (void)backAction:(UIButton *)button{
    
    [self.sideMenuViewController setContentViewController:[[MainTabBarController alloc] init]
                                                 animated:YES];
    [self.sideMenuViewController hideMenuViewController];
    
}


//是否显示设置按钮
- (void)setIsSetUpItemShow:(BOOL)isSetUpItemShow{
    
    if (isSetUpItemShow == YES) {
        
        UIButton *setUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        setUpBtn.frame = CGRectMake(0, 0, 20, 20);
        // 设置背景图片
        [setUpBtn setImage:[UIImage imageNamed:@"icon_person~iphone"] forState:UIControlStateNormal];
        // 添加事件
        [setUpBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *setUpItem = [[UIBarButtonItem alloc] initWithCustomView:setUpBtn];
        
        self.navigationItem.leftBarButtonItem = setUpItem;
        
    }
    
}


//是否让导航栏透明
- (void)setIsNavClarity:(BOOL)isNavClarity{
    
    if(isNavClarity == YES){
        
#warning 滑动隐藏导航栏思路  1.设置导航栏透明translucent 2.移除导航栏背景视图 3.tableView的frame(0,0,w,h-tabbar.h) 4.需要隐藏导航栏的automaticallyAdjustsScrollViewInsets=no(取消内填充),否则则默认 5.创建UIView添加到视图上,高度为64,为了当导航栏的背景,因为导航栏是透明,滑动的时,只需要设置UIView的alpha值,就可以实现导航栏变淡到隐藏的效果(注:UIView需要在tableView之后创建)  总结:导航栏其实还在,只是给了张背景图片,导航栏的效果也同意能使用
        
        //1.设置导航栏样式
        self.navigationController.navigationBar.translucent = YES;
        //2.移除导航栏的背景视图
        for (UIView *view in self.navigationController.navigationBar.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                //[view removeFromSuperview];//不能移除,不然titleView 在pop回来时 会消失
                view.hidden = YES;
            }
        }
        
    }
}




@end



