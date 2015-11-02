//
//  ThreeKilometersViewCtrl.m
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "ThreeKilometersViewCtrl.h"

#define NavItemButtonHW 20

@interface ThreeKilometersViewCtrl()

@end

@implementation ThreeKilometersViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载主视图
    [self initMainView];
    
}

- (void)initMainView{
    
    
    //5.设置中间标题
    // 设置titleView
    _titleButton = [TitleButton buttonWithType:UIButtonTypeCustom];
    //titleButton.frame = CGRectMake((KIPHONEWidth -50)/ 2 ,setUpBtn.top - 5, 100, NavItemButtonHW);
    _titleButton.frame = CGRectMake(0, 0, 100, NavItemButtonHW);
    [_titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    // 设置标题按钮
    //设置中读取
    NSDictionary *info = [self acquireCityInfo];
    NSNumber *cityID = [[info allKeys] lastObject];
    NSString *cityName = [info objectForKey:cityID];
    [_titleButton setTitle:cityName forState:UIControlStateNormal];
    self.navigationItem.titleView = _titleButton;
    
    //设置导航栏背景
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *backgroundImage = [UIImage imageNamed:@"barBG"];
    if (version >= 5.0) {
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    
    self.slideSwitchView = [[SUNSlideSwitchView alloc] initWithFrame:self.view.bounds];
    self.slideSwitchView.slideSwitchViewDelegate = self;
    [self.view addSubview:self.slideSwitchView];
    
    self.slideSwitchView.tabItemNormalColor = [SUNSlideSwitchView colorFromHexRGB:@"868686"];
    self.slideSwitchView.tabItemSelectedColor = [SUNSlideSwitchView colorFromHexRGB:@"bb0b15"];
    
    self.firstVC = [[FirstViewController alloc] init];
    self.firstVC.title = @"全部";
    
    self.secondVC = [[SecondViewController alloc] init];
    self.secondVC.title = @"食色性也";
    
    self.ThirdVC = [[ThirdViewController alloc] init];
    self.ThirdVC.title = @"酒余茶后";
    
    self.fourVC  = [[FourViewController alloc] init];
    self.fourVC.title = @"逍遥自得";
    
    self.slideSwitchView.titleImages = @[@"icon_category_all~iphone",@"icon_category_drink~iphone",@"icon_category_food~iphone",@"icon_category_play~iphone"];
    self.slideSwitchView.titleSelectImages = @[@"icon_category_all_down~iphone",@"icon_category_drink_down~iphone",@"icon_category_food_down~iphone",@"icon_category_play_down~iphone"];
    
    [self.slideSwitchView buildUI];
}


//点击标题按钮的时候调用
- (void)titleClick:(UIButton *)button{
    
    //跳转模态视图进行定位
    LocationViewController *locationVC = [[LocationViewController alloc] init];
    locationVC.delegate = self;
    BaseNavigationController *locationNav = [[BaseNavigationController alloc] initWithRootViewController:locationVC];
    [self presentViewController:locationNav animated:YES completion:nil];
    
}




#pragma mark -- cityID和cityName
//获取
- (NSDictionary *)acquireCityInfo{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:KThreeKLocationCityID] == nil || [userDefaults objectForKey:KLocationCityName] == nil) {
        return @{@3:@"北京"};
    }else{
        NSInteger cityId = [[userDefaults objectForKey:KThreeKLocationCityID] integerValue];
        NSString *cityName = [userDefaults objectForKey:KThreeKLocationCityName];
        return @{@(cityId):cityName};
    }
    
}
//保存
- (void)saveCityInfo:(NSInteger)cityID cityName:(NSString *)cityName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(cityID) forKey:KThreeKLocationCityID];
    [userDefaults setObject:cityName forKey:KThreeKLocationCityName];
    [userDefaults synchronize];//同步
}

#pragma mark -- SUNSlideSwitchView代理方法

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view{
    return 4;
}


- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number{
    
    if (number == 0) {
        return self.firstVC;
    } else if (number == 1) {
        return self.secondVC;
    } else if (number == 2) {
        return self.ThirdVC;
    } else if (number == 3) {
        return self.fourVC;
    } else {
        return nil;
    }
}

#pragma mark --- LocationViewController代理方法

- (void)LocationViewControllerDidSelectLocation:(LocationViewController *)locationVC locationModel:(LocationModel *)model{
    //更换标签栏地址
    [_titleButton setTitle:model.name forState:UIControlStateNormal];
    
    //保存CityID和cityName
    [self saveCityInfo:[model.cityID integerValue] cityName:model.name];
    
    //刷新所有表视图
    [self.firstVC reloadTableViewWithCityID:model.cityID];
    [self.secondVC reloadTableViewWithCityID:model.cityID];
    [self.ThirdVC reloadTableViewWithCityID:model.cityID];
    [self.fourVC reloadTableViewWithCityID:model.cityID];
    
    
}

#pragma mark -- 
- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number{
    
//    NSDictionary *info = [self acquireCityInfo];
//    NSNumber *cityID = [[info allKeys] lastObject];
    
    //直接拿到控制器 刷新表视图
//    if (number == 0) {
//        [self.firstVC reloadTableViewWithCityID:cityID];
//    } else if (number == 1) {
//        [self.secondVC reloadTableViewWithCityID:cityID];
//    } else if (number == 2) {
//        [self.ThirdVC reloadTableViewWithCityID:cityID];
//    } else if (number == 3) {
//        [self.fourVC reloadTableViewWithCityID:cityID];
//    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
