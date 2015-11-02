//
//  LocationViewController.m
//  MainHotel
//
//  Created by iMac on 15-10-8.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "LocationViewController.h"

#define XCellHeaderHeight 15

@interface LocationViewController ()

@property (nonatomic,strong) CLLocationManager *locationManger;//定位管理

@property (nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic,copy) NSString *address;//定位到的地址


@end

@implementation LocationViewController

- (void)dealloc{
    //移除通知
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载主视图 并开始定位
    [self setupMainView];
    
    //请求数据
    [self requestLocationData];
    
    
}

//数据懒加载
- (NSMutableArray *)dataList{
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (CLLocationManager *)locationManger{
    if (_locationManger == nil) {
        
        _locationManger = [[CLLocationManager alloc] init];
        _locationManger.delegate = self;
        _locationManger.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        if (iOS8) {
            [_locationManger requestWhenInUseAuthorization];
        }
    }
    return _locationManger;
}


- (void)setupMainView{
    
    
    //设置状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.title = @"选择城市";
    
    //添加返回按钮
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back_default~iphone"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backBtnItem;
    
    //建立tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.frame = CGRectMake(0, 0, KIPHONEWidth, self.view.height);
    _tableView.delegate  = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    
    
    
}


//数据请求
- (void)requestLocationData{
    //地点数据
    [DataService requestAFWithURL:KLocationData params:nil requestHeader:nil httpMethod:@"POST" block:^(id result, NSError *error) {
        
        if (result == nil) {return;}
        
        NSArray *resultArr = result[@"citylist"];
        
        NSMutableArray *locationArr = [NSMutableArray array];
        for (NSDictionary *dict in resultArr) {
            
            LocationModel *model = [[LocationModel alloc] initWithContent:dict];
            
            [locationArr addObject:model];
        }
        
        
        //转换成二维数组
        
        //字母列表
        NSArray *groupList = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"G",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",];
        
        NSMutableArray *planarArr = [NSMutableArray array];
        for (int i=0; i<groupList.count;i++) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.key isEqualToString:%@",groupList[i]];
            NSArray *newArr = [locationArr filteredArrayUsingPredicate:predicate];
            if (newArr.count > 0) {
                
                [planarArr addObject:newArr];
            }
        }
        
        //数组index=0增加一个自定义定位的cell数据
        LocationModel *model = [[LocationModel alloc] init];
        model.key = @"#";
        self.address = L(@"useLocaction");
        model.name = self.address;
        NSArray *locaArr = @[model];
        [planarArr insertObject:locaArr atIndex:0];
        
        //二维数组赋值给全局数组
        self.dataList = planarArr;
        
        
        //刷新表视图
        [_tableView reloadData];
        
        //开启定位
        [self.locationManger startUpdatingLocation];
        
    }];
    
    
    
}

//返回按钮
- (void)backAction{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //设置状态栏
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark -- tableView数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *sectionArr = self.dataList[section];
    return sectionArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseID = @"locationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    
    
    //设置数据
    NSArray *values = self.dataList[indexPath.section];
    LocationModel *model = values[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",model.name];
    
    
    return cell;
}

#pragma mark -- tableView代理
//设置组的头标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *value = self.dataList[section];
    LocationModel *model = [value firstObject];
    return model.key;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return XCellHeaderHeight;
}


//返回侧滑动标题的视图
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSMutableArray *titleArr = [NSMutableArray array];
    for (NSArray *temp in self.dataList) {
        LocationModel *model = [temp firstObject];
        NSString *key = model.key;
        [titleArr addObject:key];
    }
    return titleArr;
}
//点击单元格
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //进行定位
    if (indexPath.section == 0) {
        NSIndexPath *indexPathLoc = [NSIndexPath indexPathForRow:0 inSection:0];
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPathLoc];
        //为定位成功时,点击重新开始定位
        if ([cell.detailTextLabel.text isEqualToString:L(@"useLocaction")]) {
            
            [self.locationManger startUpdatingLocation];
            
        }else{
            //定位成功后,进行值传递
            if ([self.delegate respondsToSelector:@selector(LocationViewControllerDidSelectLocation:locationModel:)]) {
                [self.delegate LocationViewControllerDidSelectLocation:self locationModel:[self.dataList[0] firstObject]];
            }
            //关闭当前页面
            [self backAction];
        }
        
    }else{
        //点击其他位置
        NSArray *values = self.dataList[indexPath.section];
        LocationModel *model = values[indexPath.row];
        if ([self.delegate respondsToSelector:@selector(LocationViewControllerDidSelectLocation:locationModel:)]) {
            [self.delegate LocationViewControllerDidSelectLocation:self locationModel:model];
        }
        //关闭当前页面
        [self backAction];
    }
    
    
}

#pragma mark -- 定位代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //1.获取用户的位置对象
    CLLocation *location = [locations lastObject];
    //2.反地理编码
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        //定位失败
        if (placemarks.count == 0 || error) {
            
            //弹出定位失败提示(2秒后消失)
            UILabel *alterLabel = [[UILabel alloc] initWithFrame:CGRectMake(KIPHONEWidth/2-160/2, KIPHONEHeight/2 - 100, 160, 30)];
            alterLabel.text = @"定位失败,请重新定位";
            alterLabel.textColor  = [UIColor whiteColor];
            alterLabel.backgroundColor = [UIColor blackColor];
            alterLabel.alpha = .7;
            alterLabel.layer.cornerRadius = 10;
            alterLabel.layer.masksToBounds = YES;
            alterLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:alterLabel];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alterLabel removeFromSuperview];
            });
            
            [manager stopUpdatingLocation];
            return;
        }
        
        //定位成功
        CLPlacemark *pm = [placemarks firstObject];
        LocationModel *model = [self.dataList[0] firstObject];
        //NSLog(@"%@",pm.addressDictionary);
        if (pm.locality) {
            
            [self getpath:pm.locality locationModel:model];
            
            [self.dataList replaceObjectAtIndex:0 withObject:@[model]];
        }else{
            
            [self getpath:pm.administrativeArea locationModel:model];
            
            [self.dataList replaceObjectAtIndex:0 withObject:@[model]];
        }
        
        //刷新第一行cell
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
    //3.停止定位
    [manager stopUpdatingLocation];
}

//根据地址赋值给第一行数据(主要是cityID和name)
- (void)getpath:(NSString *)clPlacemark locationModel:(LocationModel *)model{
    
    for (NSArray *arr in self.dataList) {
        for (NSArray *data in arr) {
            LocationModel *tmodel = (LocationModel *)data;
            //NSLog(@"%@",tmodel.name);
            NSRange rangc = [clPlacemark rangeOfString:tmodel.name];
            if(rangc.location == NSNotFound){
                break;
            }
            model.name = tmodel.name;
            model.cityID = tmodel.cityID;
        }
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end





