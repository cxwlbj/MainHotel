//
//  FirstViewController.h
//  MainHotel
//
//  Created by iMac on 15-10-13.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseViewController.h"

#import "CustomTableView.h"


/**
 *  全部
 */
@interface FirstViewController : BaseViewController

@property (nonatomic , strong) CustomTableView *tableView;

//强制刷新数据
- (void)reloadTableViewWithCityID:(NSNumber *)cityID;

@end
