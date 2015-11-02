//
//  DetailCentreView.h
//  MainHotel
//
//  Created by iMac on 15-10-11.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelDetailModel.h"
#import "UIView+ViewController.h"
#import "RoomDetailView.h"

@interface DetailCentreView : UIView<UIAlertViewDelegate>{
    
    UILabel *_hotelName; //酒店名称
    UILabel *_hotelAdress;//酒店地址
    UIButton *_telButton;//电话按钮
    UIButton *_roomChooseButton;//房型选择按钮
    UIButton *_mapButton;//地图按钮
    UIButton *_hotelNearby;//酒店周边
    
    UILabel *_roomLabel;//房型label
    UILabel *_mapLabel;//房型label
    UILabel *_nearbyLabel;//房型label
    
    //点击房型出现的视图
    UIView *_maskView; //遮盖视图
    RoomDetailView *_roomDetailView;//房型视图
    
}

@property (nonatomic,strong) HotelDetailModel *model;

@end
