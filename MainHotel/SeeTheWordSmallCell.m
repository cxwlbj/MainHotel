//
//  SeeTheWordSmallCell.m
//  MainHotel
//
//  Created by iMac on 15-10-14.
//  Copyright (c) 2015年 ixp. All rights reserved.
//

#import "SeeTheWordSmallCell.h"

#define KTitleFont 10
#define KDetailFont 12


@implementation SeeTheWordSmallCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self setUpSubviews];
    }
    return self;
}

- (void)setUpSubviews{
    
    _imageShow = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imageShow];
    _imageShow.userInteractionEnabled = YES;
    
    _title = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_title];
    _title.font = [UIFont systemFontOfSize:KTitleFont];
    _title.numberOfLines = 0;
    
    _textDetail = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_textDetail];
    _textDetail.font = [UIFont systemFontOfSize:KDetailFont];
    _textDetail.numberOfLines = 2;
    
    _collectView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_collectView];
    [_collectView setImage:[UIImage imageNamed:@"button_zan_default"] forState:UIControlStateNormal];
    _collectView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_collectView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _collectView.titleLabel.font = [UIFont systemFontOfSize:KDetailFont];
    
    _seeView = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_seeView];
    [_seeView setImage:[UIImage imageNamed:@"icon_read~iphone"] forState:UIControlStateNormal];
    _seeView.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_seeView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _seeView.titleLabel.font = [UIFont systemFontOfSize:KDetailFont];
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    //计算frame
    
    _imageShow.frame = CGRectMake(XMargin, XMargin, 120, 80);
    _title.frame = CGRectMake(_imageShow.right + XMargin, XMargin, 120, 20);
    _textDetail.frame = CGRectMake(_title.left, _title.bottom + XMargin, KIPHONEWidth - _imageShow.width - XMargin * 6, 30);
    _collectView.frame = CGRectMake(_title.left, _textDetail.bottom + XMargin, 60, 15);
    _seeView.frame = CGRectMake(_collectView.right + XMargin * 4, _collectView.top, 70, 15);
    
    
    
    //设置内容
    [_imageShow sd_setImageWithURL:[NSURL URLWithString:self.model.img_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _title.text = [NSString stringWithFormat:@"%@",self.model.partner_name];
    _textDetail.text = [NSString stringWithFormat:@"%@",self.model.title];
    [_collectView setTitle:[NSString stringWithFormat:@"%@",self.model.likes] forState:UIControlStateNormal];
    [_seeView setTitle:[NSString stringWithFormat:@"%@",self.model.views] forState:UIControlStateNormal];
    
    
    
}

@end










