//
//  CustomTableView.m
//  MainHotel
//
//  Created by iMac on 15-10-13.
//  Copyright (c) 2015年 ixp. All rights reserved.
//


#import "CustomTableView.h"
#import "ThreeKilometersCell.h"

#define kThreeKilometersCell @"kThreeKilometersCell"

@interface CustomTableView()
//保存模型数据数组
@property (nonatomic, strong) NSArray *dataList;

@end

@implementation CustomTableView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (_homeTableView == nil) {
            _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            _homeTableView.delegate = self;
            _homeTableView.dataSource = self;
            [_homeTableView setBackgroundColor:[UIColor clearColor]];
            _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            _homeTableView.showsVerticalScrollIndicator = NO;
        }
        
        [self addSubview:_homeTableView];
        
        
    }
    return self;
}






#pragma mark -- 网络请求

- (NSArray *)dataList{
    if (!_dataList) {
        _dataList = [[NSArray  alloc] init];
    }
    return _dataList;
}

//根据城市ID和type类型请求数据,通过block返回
- (void)customTableViewRequestData:(NSNumber *)cityID type:(NSNumber *)type{
    
    [self hudProgressLoading];//加载视图
    
    NSNumber *page = @0;
    //请求体
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:cityID forKey:@"city_id"];
    [params setObject:type forKey:@"type"];
    [params setObject:page forKey:@"page"];
    
    NSString *contentType = @"application/x-www-form-urlencoded";
    
    //请求头
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    [headerDic setObject:contentType forKey:@"Content-Type"];
    
    NSString *httpMethod = @"POST";
    
    [DataService requestAFWithURL:KThreeKilometersData params:params requestHeader:headerDic httpMethod:httpMethod block:^(id result, NSError *error) {
        //NSLog(@"%@",result);
        if ([result isKindOfClass:[NSArray class]]) {
            
            //进行模型封装
            NSMutableArray *tempArr = [NSMutableArray array];
            for (NSDictionary *dic in (NSArray *)result) {
                ThreeKilometersModel *model = [[ThreeKilometersModel alloc] initWithContent:dic];
                [tempArr addObject:model];
            }
            
            //赋值给全局数组
            self.dataList = tempArr;
            
            //刷新表视图
            [self.homeTableView reloadData];
            
        }
        
        //停止刷新状态
        
        
        //停止加载效果
        [_HUD hide:YES];
        
#warning 未完成
        //显示错误提示视图
        
        
    }];
    
}

#pragma mark -- 获取和保持 城市ID和type,城市NAME

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

#pragma mark -- 加载视图
//加载进度
- (void)hudProgressLoading{
    
    if (_HUD == nil) {
        
        _HUD = [[MBProgressHUD alloc] initWithView:self];
        [self addSubview:_HUD];
        _HUD.labelText = @"加载中";
    }
    [_HUD show:YES];
    
}

//下拉刷新实现
- (void)headerRefreshData{
    
//    NSDictionary *infoDict = [self acquireCityInfo];
//    NSInteger cityID = [[[infoDict allKeys] firstObject] integerValue];
    
    
}



#pragma mark - UITableView数据源
//每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //自定义
    return self.dataList.count;
    
}

//cell定义
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_dataSource respondsToSelector:@selector(cellForRowInTableView:IndexPath:FromView:)]) {
        UITableViewCell *vCell = [_dataSource cellForRowInTableView:tableView IndexPath:indexPath FromView:self];
        return vCell;
    }else{
        
        static NSString *vMoreCellIdentify = kThreeKilometersCell;
        
        ThreeKilometersCell *vCell = [tableView dequeueReusableCellWithIdentifier:vMoreCellIdentify];
        if (vCell == Nil) {
            vCell = [[[NSBundle mainBundle] loadNibNamed:@"ThreeKilometersCell" owner:self options:Nil] lastObject];
        }
        //自定义
        vCell.model = self.dataList[indexPath.row];
        
        return vCell;
        
    }
    
    return Nil;
}

#pragma mark -- tableView代理方法
//每组单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消点中效果
    BaseNavigationController *gaodeNav = [[BaseNavigationController alloc] initWithRootViewController:[[GaoDeMapNavViewController alloc] init]];
#warning 解决和导航地图跳转模态视图错误提示
    [self.window.rootViewController presentViewController:gaodeNav
                                                animated:YES completion:nil];
    
//    [self.viewController presentViewController:gaodeNav animated:YES completion:^{
//        
//    }];
    
}



/*

#pragma mark 创建下拉刷新Header
-(void)createRefreshHeaderView{

    if (_refreshHeaderView == nil) {

        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:_homeTableView.frame];
        view.delegate = self;
        [self insertSubview:view belowSubview:_homeTableView];
        _refreshHeaderView = view;

    }

    [_refreshHeaderView refreshLastUpdatedDate];

}

#pragma mark 强制列表刷新
-(void)forceToFreshData{
    [_homeTableView setContentOffset:CGPointMake(_homeTableView.contentOffset.x,  - 66) animated:YES];
    double delayInSeconds = .2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //[_refreshHeaderView forceToRefresh:_homeTableView];
    });
}


单元格被选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == mRowCount) {
        if ([_delegate respondsToSelector:@selector(loadData:FromView:)]) {
            [_delegate loadData:^(int aAddedRowCount) {
                NSInteger vNewRowCount = aAddedRowCount;
                if (vNewRowCount > 0) {
                    NSMutableArray *indexPaths = [NSMutableArray array];
                    for (int lIndex = (int)mRowCount; lIndex < mRowCount + vNewRowCount; lIndex++) {
                        [indexPaths addObject:[NSIndexPath indexPathForRow:lIndex inSection:0]];
                    }
                    [tableView beginUpdates];
                    [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
                    [tableView endUpdates];
                    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
                }
            }FromView:self];
        }
    }else{
        if ([_delegate respondsToSelector:@selector(didSelectedRowAthIndexPath:IndexPath: FromView:)]) {
            [_delegate didSelectedRowAthIndexPath:tableView IndexPath:indexPath FromView:self];
        }
    }
}

#pragma mark Data Source Loading / Reloading Methods
- (void)reloadTableViewDataSource{

    _reloading = YES;
    if ([_delegate respondsToSelector:@selector(refreshData: FromView:)]) {
        [_delegate refreshData:^{
            [self doneLoadingTableViewData];
        } FromView:self];
    }else{
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    }
}

- (void)doneLoadingTableViewData{

  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.homeTableView];
    [self.homeTableView reloadData];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //[_refreshHeaderView egoRefreshScrollViewWillBeginScroll:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    //[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];

}

#pragma mark - EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{

    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    //	if ([_delegate respondsToSelector:@selector(tableViewEgoRefreshTableHeaderDataSourceIsLoading:FromView:)]) {
    //        BOOL vIsLoading = [_delegate tableViewEgoRefreshTableHeaderDataSourceIsLoading:view FromView:self];
    //        return vIsLoading;
    //    }
    return _reloading; // should return if data source model is reloading

}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{

    return [NSDate date]; // should return date data source was last changed

}
*/

@end

