//
//  SeeTheWordViewCtrl.m
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "SeeTheWordViewCtrl.h"

#define KSeeTheWordBigCell @"KSeeTheWordBigCell"
#define KSeeTheWordSmallCell @"KSeeTheWordSmallCell"


@interface SeeTheWordViewCtrl ()

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation SeeTheWordViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    [self initMainView];
    
    [self requestNetData];
    
}

- (void)initMainView{
    
    
    
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
    
    //导航栏搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(60, 10, 100, 30)];
    searchBar.userInteractionEnabled = NO;
    searchBar.placeholder = @"搜索";
    self.navigationItem.titleView = searchBar;
    
    
    //tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.frame = CGRectMake(0, 0, KIPHONEWidth, self.view.height - XTabBarHeight - XNavgationBarHeight);
    
    _tableView.delegate  = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    //增加头部刷新
    [_tableView addHeaderWithTarget:self action:@selector(requestNetData) dateKey:@"headerTime"];
    
    _tableView.backgroundColor = [UIColor blackColor];
    
    [self hudProgressLoading];
    
    
    
}



//请求网络数据
- (void)requestNetData{
    
    NSNumber *page = @0;
    NSString *uuidStr = @"6B50B234-0306-4C80-BB9F-98E46804B8A4";
    
    //请求体
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:uuidStr forKey:@"uuid"];
    [params setObject:page forKey:@"page"];
    
    NSString *contentType = @"application/x-www-form-urlencoded";
    
    //请求头
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    [headerDic setObject:contentType forKey:@"Content-Type"];
    
    NSString *httpMethod = @"POST";
    
    [DataService requestAFWithURL:KSeeTheWordData params:params requestHeader:headerDic httpMethod:httpMethod block:^(id result, NSError *error) {
        
        //NSLog(@"%@",result);
        
        if ([result isKindOfClass:[NSArray class]]) {
            
            //进行模型封装
            NSMutableArray *tempArr = [NSMutableArray array];
            for (NSDictionary *dic in (NSArray *)result) {
                SeeTheWordModel *model = [[SeeTheWordModel alloc] initWithContent:dic];
                [tempArr addObject:model];
            }
            
            //赋值给全局数组
            self.dataList = tempArr;
            
            //刷新表视图
            [_tableView reloadData];
            
        }
        
        //停止刷新状态
        [_tableView headerEndRefreshing];
        
        //停止加载效果
        [_HUD hide:YES];
        
#warning 未完成
        //显示错误提示视图
        
        
    }];
    
    
}

//加载进度
- (void)hudProgressLoading{
    
    if (_HUD == nil) {
        
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:_HUD];
        _HUD.labelText = @"加载中";
    }
    [_HUD show:YES];
    
}


#pragma mark -- tableView数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SeeTheWordModel *model = self.dataList[indexPath.row];
    //根据不同的数据匹配不同的模型
    if ([model.recommend intValue] == 1) {
        
        static NSString *reuseID = KSeeTheWordBigCell;
        
        SeeTheWordBigCell *bigCell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        
        if (!bigCell) {
            
            bigCell = [[SeeTheWordBigCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
            
        }
        
        //设置model
        bigCell.model = self.dataList[indexPath.row];
        
        return bigCell;
        
    }else if([model.recommend intValue] == 0){
        
        static NSString *reuseID = KSeeTheWordSmallCell;
        
        SeeTheWordSmallCell *smallCell = [tableView dequeueReusableCellWithIdentifier:reuseID];
        
        if (!smallCell) {
            smallCell = [[SeeTheWordSmallCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
        }
        
        //设置model
        smallCell.model = self.dataList[indexPath.row];
        
        return smallCell;
    }
    
    return nil;
    
}




#pragma mark -- tableView代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SeeTheWordModel *model = self.dataList[indexPath.row];
    if ([model.recommend intValue] == 1) {
        SeeTheWordBigFrame *bigframe = [[SeeTheWordBigFrame alloc] init];
        bigframe.model = model;
        //NSLog(@"%.2f",bigframe.bigCellHeight);
        return bigframe.bigCellHeight;
    }else if([model.recommend intValue] == 0){
        return 100;
    }
    
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //进行页面跳转
    SeeTheWordModel *model = self.dataList[indexPath.row];
    WebViewController *webVC = [[WebViewController alloc] init];
    webVC.contentUrl = model.content_url;
    
    webVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
