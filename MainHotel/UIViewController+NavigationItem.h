//
//  UIViewController+NavigationItem.h
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "MainTabBarController.h"

/**
 *  导航栏按钮显示
 */

@interface UIViewController (NavigationItem)

@property (nonatomic,assign) BOOL isBackItemShow;

@property (nonatomic,assign) BOOL isSetUpItemShow;

@property (nonatomic,assign) BOOL isNavClarity;//是否开启导航栏透明效果(重点)

@end
