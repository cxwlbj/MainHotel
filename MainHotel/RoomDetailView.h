//
//  RoomDetailView.h
//  MainHotel
//
//  Created by iMac on 15-10-12.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelDetailModel.h"
#import "RoomsModel.h"


/**
 *  两个类写一起
 */

/**
 *  房间cell
 */

@interface RoomDetailCell : UITableViewCell{
    UIImageView *_showImageView;//图片展示
    UILabel *_roomType;//房型
    UILabel *_roomInfo;//房间信息
    UILabel *_roomPrice;//房价价格
}

//数据模型
@property (nonatomic,strong) RoomsModel *model;

@end


/**
 *  房型详细信息
 */

@interface RoomDetailView : UIView<UITableViewDelegate,UITableViewDataSource>{
    UITableView *_tableView;//数据窗
    
}

//数据模型
@property (nonatomic,strong) HotelDetailModel *model;
//视图高度
@property (nonatomic,assign) CGFloat viewHeight;




@end


