//
//  SeeTheWordViewCtrl.h
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseViewController.h"
#import "SeeTheWordModel.h"
#import "MJRefresh.h"
#import "SeeTheWordBigCell.h"
#import "SeeTheWordSmallCell.h"
#import "SeeTheWordBigFrame.h"
#import "WebViewController.h"
#import "MBProgressHUD.h"



@interface SeeTheWordViewCtrl : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;
    MBProgressHUD *_HUD;
    
    
}

@end
