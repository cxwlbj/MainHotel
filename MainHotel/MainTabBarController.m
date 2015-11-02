//
//  MainTabBarController.m
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "MainTabBarController.h"
#import "SeeTheWordViewCtrl.h"
#import "ThreeKilometersViewCtrl.h"
#import "BoutiqueHotelViewCtrl.h"
#import "BaseNavigationController.h"

#define TabBarTag 1000

@interface MainTabBarController ()

@end

@implementation MainTabBarController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //建立视图
    [self initMainView];
    
    
}
//建立视图
- (void)initMainView{
    
    //1.设置tabbar的背景
    UIImage *tabBarImageOrigin = [UIImage imageNamed:@"barBG"];
    CGSize imageSize = CGSizeMake(KIPHONEWidth + XMargin, XTabBarHeight + XMargin);
    UIImage *tabBarImage = [UIImage originImage:tabBarImageOrigin scaleToSize:imageSize];
    [self.tabBar setBackgroundImage:tabBarImage];
    
    
    NSArray *btnImageArr = @[@"icon_homepage_normal",@"icon_category_normal",@"icon_quanquan_normal"];//定义图片数组
    NSArray *btnImageHeilightArr = @[@"icon_homepage_on",@"icon_category_on",@"icon_quanquan_on"];
    
    NSArray *btnNameArr = @[L(@"boutiqueHotel"),L(@"threeKilometers"),L(@"seeTheWorld")];//定义名字数组
    
    BoutiqueHotelViewCtrl *boutiqueHotelVC  = [[BoutiqueHotelViewCtrl alloc] init];
    [self setUpOneChildViewController:boutiqueHotelVC title:btnNameArr[0] imageName:btnImageArr[0] selImageName:btnImageHeilightArr[0]];
    
    ThreeKilometersViewCtrl *threeKilometersVC = [[ThreeKilometersViewCtrl alloc] init];
    [self setUpOneChildViewController:threeKilometersVC title:btnNameArr[1] imageName:btnImageArr[1] selImageName:btnImageHeilightArr[1]];
    
    
    SeeTheWordViewCtrl *seeTheWordVC = [[SeeTheWordViewCtrl alloc] init];
    [self setUpOneChildViewController:seeTheWordVC title:btnNameArr[2] imageName:btnImageArr[2] selImageName:btnImageHeilightArr[2]];
    
    
}

// 添加一个控制器的属性
- (void)setUpOneChildViewController:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imageName selImageName:(NSString *)selImageName
{
    vc.title = title;
    
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selImage = [UIImage imageNamed:selImageName];
    if (iOS7) {
        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    //设置选中图片
    vc.tabBarItem.selectedImage = selImage;
    //设置tabbar的字体颜色
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]} forState:UIControlStateSelected];
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
    [self addChildViewController:nav];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
