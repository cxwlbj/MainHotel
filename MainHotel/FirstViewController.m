//
//  FirstViewController.m
//  MainHotel
//
//  Created by iMac on 15-10-13.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "FirstViewController.h"

#define kHeightOfTopScrollView 54.0f

@interface FirstViewController ()



@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initMainView];
    
}


- (void)initMainView{
    
    //tableview
    self.tableView = [[CustomTableView  alloc] initWithFrame:CGRectMake(0, 0, KIPHONEWidth, self.view.height - XTabBarHeight - kHeightOfTopScrollView - XNavgationBarHeight)];
    
    [self.view addSubview:self.tableView];
    
    //请求数据
    [self.tableView customTableViewRequestData:@29 type:@0];
    
}


//强制刷新数据
- (void)reloadTableViewWithCityID:(NSNumber *)cityID{
    //默认type = 0
    [self.tableView customTableViewRequestData:cityID type:@0];
}



//获取
- (NSDictionary *)acquireCityInfo{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //程序第一次登陆默认北京
    if ([userDefaults objectForKey:KLocationCityID] == nil || [userDefaults objectForKey:KLocationCityName] == nil) {
        return @{@3:@"北京"};
    }else{
        NSInteger cityId = [[userDefaults objectForKey:KLocationCityID] integerValue];
        NSString *cityName = [userDefaults objectForKey:KLocationCityName];
        return @{@(cityId):cityName};
    }
    
}

//保存
- (void)saveCityInfo:(NSInteger)cityID cityName:(NSString *)cityName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@(cityID) forKey:KLocationCityID];
    [userDefaults setObject:cityName forKey:KLocationCityName];
    [userDefaults synchronize];//同步
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
