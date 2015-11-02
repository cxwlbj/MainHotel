//
//  BoutiqueHotelCell.h
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoutiqueHotelModel.h"

@interface BoutiqueHotelCell : UITableViewCell{
    UIImageView *_showImage;//图片展示界面
    UILabel *_priceLabel;//价格标签
    UILabel *_fullLoad;//客满标签
    UILabel *_hotelNameLabel;//酒店名称
    
    UIActivityIndicatorView *_activity;//加载视图
}


@property (nonatomic,strong) BoutiqueHotelModel *model;

@end
