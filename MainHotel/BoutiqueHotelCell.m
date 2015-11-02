//
//  BoutiqueHotelCell.m
//  MainHotel
//
//  Created by iMac on 15-10-4.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "BoutiqueHotelCell.h"

#define HotelFont 13
#define ActivityXYHW 30

#define KNomalHW 30

#define KShowImageH 160
#define KpriceWidth 80

@implementation BoutiqueHotelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpSubviews];
        
    }
    return self;
}

- (void)setUpSubviews{
    
    _showImage = [[UIImageView alloc] initWithFrame:CGRectZero];//图片展示界面
    [self.contentView addSubview:_showImage];
    _showImage.userInteractionEnabled = YES;
    
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];//价格标签
    _priceLabel.backgroundColor = ColorWithRGB(0, 0, 0, 0.8);
    _priceLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_priceLabel];
    
    _fullLoad = [[UILabel alloc] initWithFrame:CGRectZero];//客满标签
    [self.contentView addSubview:_fullLoad];
    
    _hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];//酒店名称
    [self.contentView addSubview:_hotelNameLabel];
    _hotelNameLabel.font = [UIFont systemFontOfSize:HotelFont];
    
    //加载图片
    _activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(ActivityXYHW, ActivityXYHW, ActivityXYHW, ActivityXYHW)];//指定进度轮的大小
    [_activity setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];//设置进度轮显示类型
    [_showImage addSubview:_activity];
    
    
    //图片展示界面frame
    CGFloat showImageX = 0;
    CGFloat showImageY = 0;
    CGFloat showImageW = KIPHONEWidth;
    CGFloat showImageH = KShowImageH;
    _showImage.frame = CGRectMake(showImageX, showImageY, showImageW, showImageH);
    
    
    //价格标签frame
    CGFloat priceX = 0;
    CGFloat priceY = _showImage.height * .6;
    CGFloat priceW = KpriceWidth;
    CGFloat priceH = KNomalHW;
    _priceLabel.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    
    //客满标签frame
    CGFloat fullLoadWH = KNomalHW;
    CGFloat fullLoadX = (_showImage.width - fullLoadWH)/2;
    CGFloat fullLoadY = (_showImage.height - fullLoadWH)/2;
    
    _fullLoad.frame = CGRectMake(fullLoadX, fullLoadY, fullLoadWH, fullLoadWH);
    
    //酒店名称frame
    CGFloat hotelNameX = XCellMargin;
    CGFloat hotelNameY = _showImage.bottom + XCellMargin;
    CGFloat hotelNameW = KIPHONEWidth - XCellMargin;
    CGFloat hotelNameH = KNomalHW;
    _hotelNameLabel.frame = CGRectMake(hotelNameX, hotelNameY, hotelNameW, hotelNameH);
    
    //加载图片
    _activity.frame = CGRectMake((KIPHONEWidth - KNomalHW)/2, _priceLabel.top - XCellMargin, KNomalHW, KNomalHW);
    
    
}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_activity startAnimating];
    
    //图片展示界面
    [_showImage sd_setImageWithURL:[NSURL URLWithString:self.model.images] placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [_activity stopAnimating];
    }];
    
    //价格标签
    _priceLabel.text = [NSString stringWithFormat:@"  ￥%@",self.model.price];
    
    //客满标签
    
    //酒店名称
    _hotelNameLabel.text = [NSString stringWithFormat:@"%@",self.model.name];
    
}

@end







