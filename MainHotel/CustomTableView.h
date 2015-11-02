//
//  CustomTableView.h
//  MainHotel
//
//  Created by iMac on 15-10-13.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThreeKilometersModel.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "UIView+ViewController.h"
#import "GaoDeMapNavViewController.h"
#import "BaseNavigationController.h"

@class CustomTableView;

/*
@protocol CustomTableViewDelegate <NSObject>

@optional

-(float)heightForRowAthIndexPath:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView;

-(void)didSelectedRowAthIndexPath:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView;

-(void)loadData:(void(^)(int aAddedRowCount))complete FromView:(CustomTableView *)aView;

-(void)refreshData:(void(^)())complete FromView:(CustomTableView *)aView;

- (void)tableViewWillBeginDragging:(UIScrollView *)scrollView;

- (void)tableViewDidScroll:(UIScrollView *)scrollView;

- (void)tableViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

//- (BOOL)tableViewEgoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view FromView:(CustomTableView *)aView;

@end
 */

@protocol CustomTableViewDataSource <NSObject>

@required

-(NSInteger)numberOfRowsInTableView:(UITableView *)aTableView InSection:(NSInteger)section FromView:(CustomTableView *)aView;

-(UITableViewCell *)cellForRowInTableView:(UITableView *)aTableView IndexPath:(NSIndexPath *)aIndexPath FromView:(CustomTableView *)aView;

@end

/**
 *  自定义表视图
 */
typedef void(^TableViewRquestDataBlock)(id result,NSError *error);

@interface CustomTableView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    MBProgressHUD *_HUD;//加载视图
    NSInteger     mRowCount;
}


@property (nonatomic,strong) UITableView *homeTableView;
@property (nonatomic,weak) id<CustomTableViewDataSource> dataSource;


//根据城市ID和type类型请求数据
- (void)customTableViewRequestData:(NSNumber *)cityID type:(NSNumber *)type;

/*
//@property (nonatomic,assign) BOOL reloading;
//@property (nonatomic,weak) id<CustomTableViewDelegate>  delegate;
//@property (nonatomic,strong) NSMutableArray *tableInfoArray;



//- (void)reloadTableViewDataSource;

//强制刷新表视图

//-(void)forceToFreshData;
*/


@end





