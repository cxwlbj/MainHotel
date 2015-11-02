//
//  BoutiqueHotelViewCtrl.h
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseViewController.h"
#import "RESideMenu.h"
#import "UIViewController+NavigationItem.h"
#import "BoutiqueHotelCell.h"
#import "BoutiqueHotelModel.h"
#import "RoomsModel.h"
#import "MJRefresh.h"
#import "TitleButton.h"
#import "LocationViewController.h"
#import "BaseNavigationController.h"
#import "MBProgressHUD.h"
#import "BoutiqueHotelDetailVC.h"
#import "GaoDeMapNavViewController.h"
#import "GestureView.h"
#import "HotelCollectionView.h"


@interface BoutiqueHotelViewCtrl : BaseViewController<UITableViewDelegate,UITableViewDataSource,locationViewControllerDelegate,UITabBarControllerDelegate,UINavigationControllerDelegate>{
    UIView *_navigationBarView;//自定义导航栏视图
    UITableView *_tableView;//表视图
    
    HotelCollectionView *_collectionView;//橱窗视图
    
    TitleButton *_titleButton;//头标题
    MBProgressHUD *_HUD;//加载视图
    
    
    
}

@end
