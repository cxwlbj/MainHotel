//
//  BoutiqueHotelDetailVC.h
//  MainHotel
//
//  Created by iMac on 15-10-9.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BaseViewController.h"
#import "HotelDetailModel.h"
#import "RoomsModel.h"
#import "AutoSlideScrollView.h"
#import "DetailCentreView.h"
#import "PageSliderView.h"
#import "ImageShowViewController.h"
#import "MBProgressHUD.h"



@interface BoutiqueHotelDetailVC : BaseViewController<UIScrollViewDelegate,AutoSlideScrollViewDelegate>{
    
    UIScrollView *_scrollView;//滑动视图
    
    HotelDetailModel  *_model;//数据模型
    
    UIView *_placeholderView;//头部创建一个占位图片
    
    AutoSlideScrollView *_autoSlideScrollView;//图片循环展示视图
    
    DetailCentreView *_detailCentreView;//详情视图
    
    PageSliderView *_pageSliderView ;//分页滑动视图
    
    UIButton *_priceButton;//价格标签
    
    UIButton *_bookingButton;//预订按钮
    
    MBProgressHUD *_HUD; //加载视图
}

//酒店的id
@property (nonatomic,assign) NSNumber *hotelID;
@property (nonatomic,copy) NSString *checkIn;
@property (nonatomic,copy) NSString *checkOut;

@end
