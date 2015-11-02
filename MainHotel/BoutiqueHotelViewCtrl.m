//
//  BoutiqueHotelViewCtrl.m
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BoutiqueHotelViewCtrl.h"

#define KFirstUseID @"firstID"

#define NavItemButtonHW 20

@interface BoutiqueHotelViewCtrl ()

@property (nonatomic,strong) NSArray *dataList;

@property (nonatomic,copy) NSString *address;//地点

@property (nonatomic,assign) NSInteger cityID;//cityID

@property (nonatomic,assign) CGFloat scrollY; //首页视图偏移量,用于判断隐藏和显示nav

@end

@implementation BoutiqueHotelViewCtrl



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //设置导航栏透明度
    _navigationBarView.alpha = 1;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //加载视图
    [self setUpMainView];
    
    
    //加载数据
    NSString *checkin = [self requestTimeAfterDay:1];
    NSString *checkout = [self requestTimeAfterDay:2];
    NSDictionary *infoDict = [self acquireCityInfo];
    NSInteger cityID = [[[infoDict allKeys] firstObject] integerValue];
    [self requestNetData:cityID checkin:checkin checkout:checkout];
    
}


- (void)setUpMainView{
    
    
    //tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
#warning 消除tableView被tabbar和navigationbar(分隐藏和未隐藏)遮挡,设置好frame
    _tableView.frame = CGRectMake(0, 0, KIPHONEWidth, self.view.height - self.tabBarController.tabBar.height );
    
    _tableView.delegate  = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    //增加头部刷新
    [_tableView addHeaderWithTarget:self action:@selector(headerRefresh) dateKey:@"headerTime"];
    
    _tableView.backgroundColor = [UIColor blackColor];
    
    
    //collectionView
    
//    _collectionView = [[HotelCollectionView alloc] initWithFrame:_tableView.bounds];
//    _collectionView.layoutItemWidth = KIPHONEWidth * .75;
//    [self.view addSubview:_collectionView];
    
    
    //创建可以隐藏的导航栏
    [self setUpNavBar];
    
    
    //加载进度
    [self hudProgressLoading];
    

    
    
}




- (void)setUpNavBar{
    
    //取消标题
    self.navigationItem.title = @"";
    
    //设置自定义navigationbar
    
    //1.隐藏系统导航栏(设置透明效果) UIViewController的类目中
    self.isNavClarity = YES;
    //2.自定义
    _navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KIPHONEWidth, XNavgationBarHeight)];
    _navigationBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navigationBarView];
    //3.设置背景
    UIImageView *barImageView = [[UIImageView alloc] initWithFrame:_navigationBarView.bounds];
    [_navigationBarView addSubview:barImageView];
    barImageView.userInteractionEnabled = YES;
    UIImage *tabBarImageOrigin = [UIImage imageNamed:@"barBG"];
    CGSize imageSize = CGSizeMake(KIPHONEWidth + XMargin, XNavgationBarHeight + XMargin);
    UIImage *tabBarImage = [UIImage originImage:tabBarImageOrigin scaleToSize:imageSize];
    barImageView.image = tabBarImage;
    
    
    //4.设置右边个人中心按钮
    UIButton *setUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setUpBtn.frame = CGRectMake(30, XStateBarHeight + (XNavgationBarHeight - XStateBarHeight - NavItemButtonHW) / 2, NavItemButtonHW, NavItemButtonHW);
    // 设置背景图片
    [setUpBtn setImage:[UIImage imageNamed:@"icon_person~iphone"] forState:UIControlStateNormal];
    // 添加事件
    [setUpBtn addTarget:self action:@selector(presentLeftMenuViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setUpBtn];
    
    
    //5.设置中间标题
    // 设置titleView
    _titleButton = [TitleButton buttonWithType:UIButtonTypeCustom];
    //titleButton.frame = CGRectMake((KIPHONEWidth -50)/ 2 ,setUpBtn.top - 5, 100, NavItemButtonHW);
    _titleButton.frame = CGRectMake(0, 0, 100, NavItemButtonHW);
    [_titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    // 设置标题按钮
    NSDictionary *infoDict = [self acquireCityInfo];
    NSInteger cityID = [[[infoDict allKeys] firstObject] integerValue];
    NSString *address = [infoDict objectForKey:@(cityID)];
    [_titleButton setTitle:address forState:UIControlStateNormal];
    self.navigationItem.titleView = _titleButton;
    
    
    
    
    //6.设置左边地图按钮
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    mapBtn.frame = CGRectMake(KIPHONEWidth - NavItemButtonHW - 30,setUpBtn.top, NavItemButtonHW, NavItemButtonHW);
    // 设置背景图片
    [mapBtn setImage:[UIImage imageNamed:@"icon_map~iphone"] forState:UIControlStateNormal];
    // 添加事件
    [mapBtn addTarget:self action:@selector(mapButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mapBtn];

    
    //设置tabbar代理
    self.tabBarController.delegate = self;
    
    
    
}


//加载进度
- (void)hudProgressLoading{
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    
    _HUD.labelText = @"加载中";
    [_HUD show:YES];
    
    
}

//下拉刷新实现
- (void)headerRefresh{
    
    NSString *checkin = [self requestTimeAfterDay:1];
    NSString *checkout = [self requestTimeAfterDay:2];
    NSDictionary *infoDict = [self acquireCityInfo];
    NSInteger cityID = [[[infoDict allKeys] firstObject] integerValue];
    [self requestNetData:cityID checkin:checkin checkout:checkout];
}

//数据懒加载
- (NSArray *)dataList{
    if (_dataList == nil) {
        _dataList = [[NSArray alloc] init];
    }
    return _dataList;
}

//请求网络数据
- (void)requestNetData:(NSInteger)cityID checkin:(NSString *)checkin checkout:(NSString *)checkout{
    
    
    NSNumber *page = @0;
    //请求体
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:checkin forKey:@"checkin"];
    [params setObject:checkout forKey:@"checkout"];
    [params setObject:@(cityID) forKey:@"cityID"];
    [params setObject:page forKey:@"page"];
    
    NSString *contentType = @"application/x-www-form-urlencoded";
    
    //请求头
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    [headerDic setObject:contentType forKey:@"Content-Type"];
    
    NSString *httpMethod = @"POST";
    
    [DataService requestAFWithURL:KBoutiqueHotelData params:params requestHeader:headerDic httpMethod:httpMethod block:^(id result, NSError *error) {
        //NSLog(@"%@",result);
        if ([result isKindOfClass:[NSArray class]]) {
            
            //进行模型封装
            NSMutableArray *tempArr = [NSMutableArray array];
            for (NSDictionary *dic in (NSArray *)result) {
                BoutiqueHotelModel *model = [[BoutiqueHotelModel alloc] initWithContent:dic];
                //rooms进行模型封装
                NSMutableArray *roomArr = [NSMutableArray array];
                for (NSDictionary *roomDic in model.rooms) {
                    RoomsModel *roomModel = [[RoomsModel alloc] initWithContent:roomDic];
                    [roomArr addObject:roomModel];
                }
                model.rooms = roomArr;
                [tempArr addObject:model];
                
            }
            
            //赋值给全局数组
            self.dataList = tempArr;
            
            _collectionView.dataList = tempArr;
            
            //刷新表视图
            [_tableView reloadData];
            //刷新collectionView
            [_collectionView reloadData];
            
        }
        
        //停止刷新状态
        [_tableView headerEndRefreshing];
        
        //停止加载效果
        [_HUD hide:YES];
        
#warning 未完成
        //显示错误提示视图
        
        
    }];
    
    
}

//点击右侧map按钮跳转事件
- (void)mapButtonClick:(UIButton *)button{
    
//    GaoDeMapNavViewController *gaodeNavVC = [[GaoDeMapNavViewController alloc] init];
//    gaodeNavVC.hidesBottomBarWhenPushed = YES;
//    [self.view.window.rootViewController presentViewController:gaodeNavVC animated:YES completion:nil];
    NSLog(@"mapButton");
}

//点击标题按钮的时候调用
- (void)titleClick:(UIButton *)button{
    
    //跳转模态视图进行定位
    LocationViewController *locationVC = [[LocationViewController alloc] init];
    locationVC.delegate = self;
    BaseNavigationController *locationNav = [[BaseNavigationController alloc] initWithRootViewController:locationVC];
    [self presentViewController:locationNav animated:YES completion:nil];
    
}

//通知事件
- (void)refreshTableView:(NSNotification *)notification{
    [_tableView headerBeginRefreshing];
}


#pragma mark --  UITableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseID = @"BoutiqueHotelCell";
    BoutiqueHotelCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[BoutiqueHotelCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    
    //没有数据的时候隐藏cell
    if (self.dataList.count == 0) {
        cell.hidden = YES;
    }else{
        cell.hidden = NO;
    }
    
    //设置cell内容
    if (self.dataList.count > 0) {
        
        BoutiqueHotelModel *model = self.dataList[indexPath.row];
        cell.model = model;
    }
    
    
    return cell;
    
}

#pragma mark -- tabbar代理
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //刚点击首页时候刷新表视图
//    if (tabBarController.selectedIndex == 0) {
//        //下拉
//        [_tableView headerBeginRefreshing];
//        [self headerRefresh];
//    }
    
    
}


#pragma mark --  UITableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell高度 加上20的间距
    return 210;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //点击进行跳转详细页面
    BoutiqueHotelDetailVC *boutiqueHotelDetailVC = [[BoutiqueHotelDetailVC alloc] init];
    boutiqueHotelDetailVC.hidesBottomBarWhenPushed = YES;
    
    //值传递
    BoutiqueHotelModel *model = self.dataList[indexPath.row];
    boutiqueHotelDetailVC.hotelID = model._id;
    boutiqueHotelDetailVC.checkIn = [self requestTimeAfterDay:1];
    boutiqueHotelDetailVC.checkOut = [self requestTimeAfterDay:2];
    
    [self.navigationController pushViewController:boutiqueHotelDetailVC animated:YES];
    
    
    
}

#pragma mark --locationViewControllerDelegate代理
- (void)LocationViewControllerDidSelectLocation:(LocationViewController *)locationVC locationModel:(LocationModel *)model{
    //更换标签栏地址
    [_titleButton setTitle:model.name forState:UIControlStateNormal];
    
    //根据cityID 刷新表视图
    NSString *checkin = [self requestTimeAfterDay:1];
    NSString *checkout = [self requestTimeAfterDay:2];
    //保存CityID
    [self saveCityInfo:[model.cityID integerValue] cityName:model.name];
    
    [self requestNetData:[model.cityID integerValue] checkin:checkin checkout:checkout];
    [_HUD show:YES];
}


#pragma mark -- 获取当前系统时间
//根据当前时间获取N天后的time
- (NSString *)requestTimeAfterDay:(NSUInteger)day{
    
    //NSDate *date = [NSDate date];
    //dateWithTimeIntervalSinceNow N天此刻的时间点
    NSDate *afterDate = [NSDate dateWithTimeIntervalSinceNow:+ day*24*3600];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY.MM.dd"];
    NSString *locationTime = [dateFormatter stringFromDate:afterDate];
    
    return locationTime;
    
}

#pragma mark -- cityID
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


#pragma mark -- UIScrollView视图
//视图滑动时候
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"%.2f",scrollView.contentOffset.y);
    CGFloat yOffset = scrollView.contentOffset.y;
    double alphaValue = scrollView.contentOffset.y / (double)XNavgationBarHeight;
    if (yOffset > 0) {
        
        if (alphaValue < 1) {
            _navigationBarView.alpha = 1 - alphaValue;
        }else{
            _navigationBarView.alpha = 0;
        }
        
    }else if (yOffset < 0){
        _navigationBarView.alpha = 1;
    }
    
    //滑动透明效果显示背景
    //launchScreen
    //预定界面视图后侧效果
    
    
    
}

#pragma mark -- UINavigationController代理


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end





