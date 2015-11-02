//
//  LocationViewController.h
//  MainHotel
//
//  Created by iMac on 15-10-8.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseViewController.h"
#import "LocationModel.h"
#import <CoreLocation/CoreLocation.h>
#import <ImageIO/ImageIO.h>

/**
 *  定位视图
 */

@class LocationViewController;
@protocol locationViewControllerDelegate <NSObject>

@optional
- (void)LocationViewControllerDidSelectLocation:(LocationViewController *)locationVC locationModel:(LocationModel *)model;

@end

@interface LocationViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>{
    UITableView *_tableView;//
    UIActivityIndicatorView *_activityView;//加载视图
}

@property (nonatomic,weak) id<locationViewControllerDelegate> delegate;

@end
