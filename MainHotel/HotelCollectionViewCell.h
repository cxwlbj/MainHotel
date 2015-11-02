//
//  HotelCollectionViewCell.h
//  MainHotel
//
//  Created by iMac on 15-10-19.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoutiqueHotelModel.h"

@interface HotelCollectionViewCell : UICollectionViewCell{
    UIImageView *_showImage; //图片展示
    UILabel *_priceLabel; //价格标签
    UILabel *_fullLoad;//客满标签
    UILabel *_hotelNameLabel; //名称标签
    
    UIActivityIndicatorView *_activity;//加载视图
}



@property (nonatomic,strong) UIView *baseView;

//数据模型属性
@property (nonatomic,strong) BoutiqueHotelModel *model;

@property (nonatomic,assign) BOOL isDetail; //是否显示详细页面

//翻转单元格的方法
- (void)flipCell;


@end
